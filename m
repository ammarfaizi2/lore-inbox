Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760180AbWLDBEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760180AbWLDBEq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 20:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760181AbWLDBEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 20:04:46 -0500
Received: from mga01.intel.com ([192.55.52.88]:47957 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1760180AbWLDBEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 20:04:45 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,490,1157353200"; 
   d="scan'208"; a="172364923:sNHT56729358"
Subject: Re: [patch 14/23] x86 microcode: dont check the size
From: Shaohua Li <shaohua.li@intel.com>
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061202064454.GE1736@1wt.eu>
References: <20061129220111.137430000@sous-sol.org>
	 <20061129220524.148156000@sous-sol.org>  <20061202064454.GE1736@1wt.eu>
Content-Type: text/plain
Date: Mon, 04 Dec 2006 09:04:03 +0800
Message-Id: <1165194243.29089.0.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-12-02 at 07:44 +0100, Willy Tarreau wrote:
> Shaohua,
> 
> this one seems appropriate for 2.4 too. It is OK for you if I merge it ?
Yes, 2.4 and 2.6 use the same driver. It should be fine to merge it.

Thanks,
Shaohua

> On Wed, Nov 29, 2006 at 02:00:25PM -0800, Chris Wright wrote:
> > -stable review patch.  If anyone has any objections, please let us know.
> > ------------------
> > 
> > From: Shaohua Li <shaohua.li@intel.com>
> > 
> > IA32 manual says if micorcode update's size is 0, then the size is
> > default size (2048 bytes). But this doesn't suggest all microcode
> > update's size should be above 2048 bytes to me. We actually had a
> > microcode update whose size is 1024 bytes. The patch just removed the
> > check.
> > 
> > Backported to 2.6.18 by Daniel Drake.
> > 
> > Signed-off-by: Daniel Drake <dsd@gentoo.org>
> > Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> > ---
> >  arch/i386/kernel/microcode.c |    9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> > 
> > --- linux-2.6.18.4.orig/arch/i386/kernel/microcode.c
> > +++ linux-2.6.18.4/arch/i386/kernel/microcode.c
> > @@ -250,14 +250,14 @@ static int find_matching_ucodes (void) 
> >  		}
> >  
> >  		total_size = get_totalsize(&mc_header);
> > -		if ((cursor + total_size > user_buffer_size) || (total_size < DEFAULT_UCODE_TOTALSIZE)) {
> > +		if (cursor + total_size > user_buffer_size) {
> >  			printk(KERN_ERR "microcode: error! Bad data in microcode data file\n");
> >  			error = -EINVAL;
> >  			goto out;
> >  		}
> >  
> >  		data_size = get_datasize(&mc_header);
> > -		if ((data_size + MC_HEADER_SIZE > total_size) || (data_size < DEFAULT_UCODE_DATASIZE)) {
> > +		if (data_size + MC_HEADER_SIZE > total_size) {
> >  			printk(KERN_ERR "microcode: error! Bad data in microcode data file\n");
> >  			error = -EINVAL;
> >  			goto out;
> > @@ -460,11 +460,6 @@ static ssize_t microcode_write (struct f
> >  {
> >  	ssize_t ret;
> >  
> > -	if (len < DEFAULT_UCODE_TOTALSIZE) {
> > -		printk(KERN_ERR "microcode: not enough data\n"); 
> > -		return -EINVAL;
> > -	}
> > -
> >  	if ((len >> PAGE_SHIFT) > num_physpages) {
> >  		printk(KERN_ERR "microcode: too much data (max %ld pages)\n", num_physpages);
> >  		return -EINVAL;
> > 
> > --
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
