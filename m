Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWBURQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWBURQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 12:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWBURQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 12:16:26 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:5867 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932338AbWBURQZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 12:16:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cc5em6trVJSrYexjTl0+r8ys2WarUfTi9VS9mBT00W0Sga2pPtbZ9Wuk8puyYKlxJ6Cp5HKuMOflXAq1y3n7+ojinY3tklw0GP6HmozMgpnxjTeCVxUOGGvPCQiDIQMChu9bbAcKc0tGA3D+mGHfUgcSgHXgQ87rAcAUSTYp4xM=
Message-ID: <6bffcb0e0602210916n3ddbd50i@mail.gmail.com>
Date: Tue, 21 Feb 2006 18:16:23 +0100
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.15-rt17
Cc: linux-kernel@vger.kernel.org, "Esben Nielsen" <simlo@phys.au.dk>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Steven Rostedt" <rostedt@goodmis.org>
In-Reply-To: <20060221155548.GA30146@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060221155548.GA30146@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/02/06, Ingo Molnar <mingo@elte.hu> wrote:
> i have released the 2.6.15-rt17 tree, which can be downloaded from the
> usual place:
[snip]
> to build a 2.6.15-rt17 tree, the following patches should be applied:
>
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.15.tar.bz2
>   http://redhat.com/~mingo/realtime-preempt/patch-2.6.15-rt17
>
>         Ingo

I have noticed some bugs

----------------------------->
| new stack-footprint maximum: swapper/0, 788 bytes (out of 4044 bytes).
------------|
{   24} [<c0135e7d>] debug_stackoverflow+0x80/0xb2
{   28} [<c01364e9>] __mcount+0x3b/0xb2
{   20} [<c010ebd8>] mcount+0x14/0x18
{  124} [<c01dc5cf>] number+0xe/0x204
{   76} [<c01dcbc3>] vsnprintf+0x3fe/0x438
{   28} [<c01dcc18>] vscnprintf+0x1b/0x2b
{  128} [<c011bd04>] vprintk+0x7a/0x23d
{   20} [<c011bc88>] printk+0x18/0x1a
{  172} [<c010ec2a>] MP_processor_info+0x4a/0x1b4
{   36} [<c010ee2e>] mp_register_lapic+0x9a/0xa0
{   24} [<c0482d5e>] acpi_parse_lapic+0x45/0x56
{   28} [<c048dda6>] acpi_table_parse_madt_family+0xb0/0x100
{   28} [<c048de10>] acpi_table_parse_madt+0x1a/0x1c
{   32} [<c048312a>] acpi_parse_madt_lapic_entries+0x49/0x9a
{    8} [<c048327d>] acpi_process_madt+0x23/0xb3
{   24} [<c0483540>] acpi_boot_init+0x3c/0x4c
{   20} [<c04805d4>] setup_arch+0x1af/0x1ed
{   24} [<c047c72f>] start_kernel+0x30/0x19a


----------------------------->
----------------------------->
| new stack-footprint maximum: rcS/332, 2224 bytes (out of 4044 bytes).
| new stack-footprint maximum: rcS/332, 2224 bytes (out of 4044 bytes).
------------|
------------|
{   24} {   24} [<c0135e7d>] [<c0135e7d>]
debug_stackoverflow+0x80/0xb2debug_stackoverflow+0x80/0xb2

{   28} {   28} [<c01364e9>] [<c01364e9>] __mcount+0x3b/0xb2__mcount+0x3b/0xb2

{   20} {   20} [<c010ebd8>] [<c010ebd8>] mcount+0x14/0x18mcount+0x14/0x18

{   12} {   12} [<c02c3404>] [<c02c3404>]
_raw_spin_lock+0x9/0x26_raw_spin_lock+0x9/0x26

{   16} {   16} [<c02c2a18>] [<c02c2a18>]
__lock_text_start+0x20/0x55__lock_text_start+0x20/0x55

{   32} {   32} [<c015ee47>] [<c015ee47>]
kmem_cache_alloc+0x50/0xb8kmem_cache_alloc+0x50/0xb8

{   16} {   16} [<c0148603>] [<c0148603>]
mempool_alloc_slab+0x13/0x15mempool_alloc_slab+0x13/0x15

{   52} {   52} [<c01484e3>] [<c01484e3>]
mempool_alloc+0x3f/0xdamempool_alloc+0x3f/0xda

{   24} {   24} [<c01d815c>] [<c01d815c>]
as_set_request+0x21/0x76as_set_request+0x21/0x76

{   24} {   24} [<c01cfea3>] [<c01cfea3>]
elv_set_request+0x24/0x34elv_set_request+0x24/0x34

{   44} {   44} [<c01d21b9>] get_request+0x173/0x279
{   60} [<c01d22de>] get_request_wait+0x1f/0xd2
{   76} [<c01d2eeb>] __make_request+0x2c2/0x42d[<c01d21b9>]
{   60} get_request+0x173/0x279[<c01d31e0>]
generic_make_request+0x108/0x11a{   60}
[<c01d22de>] {   60} get_request_wait+0x1f/0xd2[<c01d32cb>]
submit_bio+0xd9/0xe2{   76}
[<c01d2eeb>] {   36} __make_request+0x2c2/0x42d[<c0166a92>]
submit_bh+0x10f/0x131{   60}
[<c01d31e0>] {   20} generic_make_request+0x108/0x11a[<c0164a80>]
__bread_slow+0x51/0x8d{   60}
[<c01d32cb>] {   12} submit_bio+0xd9/0xe2
[<c0164d32>] {   36} __bread+0x2b/0x32[<c0166a92>]
submit_bh+0x10f/0x131{   48}
[<c019bc1b>] {   20} ext3_get_branch+0x6a/0xea[<c0164a80>]
__bread_slow+0x51/0x8d{  120}
[<c019c136>] {   12} ext3_get_block_handle+0xab/0x289[<c0164d32>]
__bread+0x2b/0x32{   40}
[<c019c389>] {   48} ext3_get_block+0x75/0x7c[<c019bc1b>]
ext3_get_branch+0x6a/0xea{  328}
[<c01834ca>] {  120} do_mpage_readpage+0x14d/0x383[<c019c136>]
ext3_get_block_handle+0xab/0x289{   84}
[<c0183779>] {   40} mpage_readpages+0x79/0xf4[<c019c389>]
ext3_get_block+0x75/0x7c{   24}
[<c019d0c4>] {  328} ext3_readpages+0x1b/0x1d[<c01834ca>]
do_mpage_readpage+0x14d/0x383{   76}
[<c014bb7a>] {   84} read_pages+0x2a/0xcd[<c0183779>]
mpage_readpages+0x79/0xf4{   56}
{   24} [<c019d0c4>] [<c014bd6d>]
ext3_readpages+0x1b/0x1d__do_page_cache_readahead+0x150/0x185

{   76} {   28} [<c014bb7a>] [<c014be56>]
read_pages+0x2a/0xcddo_page_cache_readahead+0x40/0x4c

{   56} {   60} [<c014bd6d>] [<c0146943>]
__do_page_cache_readahead+0x150/0x185filemap_nopage+0x148/0x2e8

{   28} {   60} [<c014be56>] [<c0151def>]
do_page_cache_readahead+0x40/0x4cdo_no_page+0x98/0x2a7

{   60} {   48} [<c0146943>] [<c015212f>]
filemap_nopage+0x148/0x2e8__handle_mm_fault+0xc5/0x17d

{   60} {   76} [<c0151def>] [<c02c4576>]
do_no_page+0x98/0x2a7do_page_fault+0x16b/0x494

{   48} {   80} [<c015212f>] [<c01037df>]
__handle_mm_fault+0xc5/0x17derror_code+0x4f/0x54

{   76} {   16} [<c02c4576>] [<c0188529>]
do_page_fault+0x16b/0x494padzero+0x23/0x34

{   80} {  140} [<c01037df>] [<c0189484>]
error_code+0x4f/0x54load_elf_binary+0x752/0xa9f

{   16} {   40} [<c0188529>] [<c016cd86>]
padzero+0x23/0x34search_binary_handler+0xcc/0x299

{  140} {  164} [<c0189484>] [<c0188461>]
load_elf_binary+0x752/0xa9fload_script+0x195/0x1a8

{   40} {   40} [<c016cd86>] [<c016cd86>]
search_binary_handler+0xcc/0x299search_binary_handler+0xcc/0x299

{  164} {   32} [<c0188461>] [<c016d0c4>]
load_script+0x195/0x1a8do_execve+0x171/0x21c

{   40} {   36} [<c016cd86>] [<c01019da>]
search_binary_handler+0xcc/0x299sys_execve+0x2f/0x74

{   32} {=2212} [<c016d0c4>] [<c0102c7e>]
do_execve+0x171/0x21csyscall_call+0x7/0xb

{   36} <---------------------------

[<c01019da>] sys_execve+0x2f/0x74
{=2212} [<c0102c7e>] syscall_call+0x7/0xb
<---------------------------

Here is config http://www.stardust.webpages.pl/files/rt/2.6.15-rt17/rt-config
Here is dmesg http://www.stardust.webpages.pl/files/rt/2.6.15-rt17/rt-dmesg

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
