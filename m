Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWCNDXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWCNDXT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 22:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbWCNDXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 22:23:18 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:18052 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750705AbWCNDXR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 22:23:17 -0500
Message-ID: <20060313222310.o7zqfxiowgo4cos0@imap.linux.ibm.com>
Date: Mon, 13 Mar 2006 22:23:10 -0500
From: Maneesh Soni <maneesh@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Laurent Riffard <laurent.riffard@free.fr>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Alasdair G Kergon <agk@redhat.com>,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>, OH@in.ibm.com
Subject: Re: 2.6.16-rc6-mm1: BUG at fs/sysfs/inode.c:180
References: <20060312031036.3a382581.akpm@osdl.org>
	<44146C31.3010905@free.fr> <20060312150158.3c7be5c3.akpm@osdl.org>
	<20060313140031.GB13206@in.ibm.com> <4415A634.6040705@free.fr>
	<20060313192226.GB1482@kroah.com>
In-Reply-To: <20060313192226.GB1482@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.4)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Greg KH <greg@kroah.com>:

> On Mon, Mar 13, 2006 at 06:04:52PM +0100, Laurent Riffard wrote:
>>
>> Le 13.03.2006 15:00, Maneesh Soni a ?crit :
>> > On Sun, Mar 12, 2006 at 03:01:58PM -0800, Andrew Morton wrote:
>> >>Laurent Riffard <laurent.riffard@free.fr> wrote:
>> >>>Le 12.03.2006 12:10, Andrew Morton a ?crit :
>> >>> > 
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm1/
>> >>>
>> >>> Hello,
>> >>>
>> >>> This kernel hangs on boot while trying to activate logical
>> >>> volumes from initrd:
>> >>>
>> >>> ------------[ cut here ]------------
>> >>> kernel BUG at fs/sysfs/inode.c:180!
>> >>> invalid opcode: 0000 [#1]
>> >>> last sysfs file: /block/ram0/dev
>> >>> Modules linked in: dm_mirror dm_mod
>> >>> CPU:    0
>> >>> EIP:    0060:[<c0172e71>]    Not tainted VLI
>> >>> EFLAGS: 00010246   (2.6.16-rc6-mm1 #123)
>> >>> EIP is at sysfs_get_name+0xd/0x46
>> >>> eax: c15a49c8   ebx: dfe2b988   ecx: dff254d8   edx: c15a49cc
>> >>> esi: dfe87b05   edi: dfe2b988   ebp: dfe67d28   esp: dfe67d28
>> >>> ds: 007b   es: 007b   ss: 0068
>> >>> Process vgchange (pid: 242, threadinfo=dfe67000 task=dfe175d0)
>> >>> Stack: <0>dfe67d44 c01738c3 dffdc4b4 c15a49c8 dfe2b988 ffffffef 
>> dfe2b98d dfe67d60
>> >>>        c0173dcd dff2a804 dfe2b984 dfe2b984 00000001 fffffffe 
>> dfe67d74 c0173f3b
>> >>>        dfe67d6c c15a84d4 dfe2b984 dfe67d90 c01a33fd c03242d0 
>> 00000004 dfe2b8f8
>> >>> Call Trace:
>> >>>  [<c0103a31>] show_stack_log_lvl+0x8b/0x95
>> >>>  [<c0103b69>] show_registers+0x12e/0x194
>> >>>  [<c0103e62>] die+0x14e/0x1db
>> >>>  [<c01040ba>] do_trap+0x7c/0x96
>> >>>  [<c0104319>] do_invalid_op+0x89/0x93
>> >>>  [<c01034db>] error_code+0x4f/0x54
>> >>>  [<c01738c3>] sysfs_dirent_exist+0x1c/0x65
>> >>>  [<c0173dcd>] create_dir+0x55/0x17d
>> >>>  [<c0173f3b>] sysfs_create_dir+0x46/0x61
>> >>>  [<c01a33fd>] kobject_add+0xa4/0x14c
>> >>>  [<c017267e>] register_disk+0x4b/0xe9
>> >>>  [<c019c28c>] add_disk+0x2e/0x3d
>> >>>  [<e08198a5>] create_aux+0x27e/0x2d7 [dm_mod]
>> >>>  [<e081991d>] dm_create+0xe/0x10 [dm_mod]
>> >>>  [<e081c317>] dev_create+0x4a/0x239 [dm_mod]
>> >>>  [<e081c18c>] ctl_ioctl+0x203/0x238 [dm_mod]
>> >>>  [<c0156648>] do_ioctl+0x3c/0x4f
>> >>>  [<c0156851>] vfs_ioctl+0x1f6/0x20d
>> >>>  [<c0156892>] sys_ioctl+0x2a/0x44
>> >>>  [<c01029bb>] sysenter_past_esp+0x54/0x75
>> >>> Code: 0b 30 01 72 85 28 c0 ff 06 31 db eb 07 89 f8 e8 d1 8d fe 
>> ff 83 c4 10 89 d8 5b 5e 5f c9 c3 55 85 c0 89 e5 74 06 83 78 14 00 75 
>> 08 <0f> 0b b4 00 73 d3 28 c0 8b 50 18 83 fa 08 74 22 7f 0a 83 fa 02
>> >>
>> >>Thanks.
>> >>
>> >>Greg, can you please interpret this?  What does this BUG:
>> >>
>> >>const unsigned char * sysfs_get_name(struct sysfs_dirent *sd)
>> >>{
>> >>	struct attribute * attr;
>> >>	struct bin_attribute * bin_attr;
>> >>	struct relay_attribute * rel_attr;
>> >>	struct sysfs_symlink  * sl;
>> >>
>> >>	if (!sd || !sd->s_element)
>> >>		BUG();
>> >>
>> >>tell us?
>> >>
>> >
>> >
>> > I think here we have sd->s_element as NULL. This is probably due to
>> > my mistake in
>> >
>> > 
>> gregkh-driver-sysfs-fix-problem-with-duplicate-sysfs-directories-and-files.patch
>> >
>> > NULL s_element which is used as cursor element is added to the s_children
>> > list in sysfs_dir_open() and is removed in sysfs_dir_close(). So if in
>> > between s_children is parsed, one can see sysfs_dirent with NULL 
>> s_element.
>> >
>> > Please try the following patch on top of -mm1
>> >
>> >
>> > Thanks
>> > Maneesh
>> >
>> >
>> >
>> >
>> > o sysfs_dirent_exist() should ignore sysfs_dirent with NULL s_element
>> >   as such element could have been added internally as cursor due to
>> >   ->open() on parent directory.
>> >
>> > Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
>> > ---
>> >
>> >  linux-2.6.16-rc6-mm1-maneesh/fs/sysfs/dir.c |   12 +++++++-----
>> >  1 files changed, 7 insertions(+), 5 deletions(-)
>> >
>> > diff -puN fs/sysfs/dir.c~fix-sysfs-check-existing-sysfs_dirent 
>> fs/sysfs/dir.c
>> > --- 
>> linux-2.6.16-rc6-mm1/fs/sysfs/dir.c~fix-sysfs-check-existing-sysfs_dirent	2006-03-13 14:48:34.000000000 
>> +0530
>> > +++ linux-2.6.16-rc6-mm1-maneesh/fs/sysfs/dir.c	2006-03-13 
>> 15:01:32.934811856 +0530
>> > @@ -63,11 +63,13 @@ int sysfs_dirent_exist(struct sysfs_dire
>> >  	struct sysfs_dirent * sd;
>> >
>> >  	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
>> > -		const unsigned char * existing = sysfs_get_name(sd);
>> > -		if (strcmp(existing, new))
>> > -			continue;
>> > -		else
>> > -			return -EEXIST;
>> > +		if (sd->s_element) {
>> > +			const unsigned char * existing = sysfs_get_name(sd);
>> > +			if (strcmp(existing, new))
>> > +				continue;
>> > +			else
>> > +				return -EEXIST;
>> > +		}
>> >  	}
>> >
>> >  	return 0;
>> > _
>> >
>>
>> Ok, with this one, it works fine.
>
> Thanks Maneesh for the quick fix, want me to merge this with your
> previous patch?
>

Yes, merging will be good.

Thanks
Maneesh
