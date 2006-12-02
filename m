Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755523AbWLBGpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523AbWLBGpG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 01:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759293AbWLBGpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 01:45:05 -0500
Received: from 1wt.eu ([62.212.114.60]:16389 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1755523AbWLBGpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 01:45:04 -0500
Date: Sat, 2 Dec 2006 07:44:54 +0100
From: Willy Tarreau <w@1wt.eu>
To: shaohua.li@intel.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 14/23] x86 microcode: dont check the size
Message-ID: <20061202064454.GE1736@1wt.eu>
References: <20061129220111.137430000@sous-sol.org> <20061129220524.148156000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129220524.148156000@sous-sol.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaohua,

this one seems appropriate for 2.4 too. It is OK for you if I merge it ?

Thanks,
Willy

On Wed, Nov 29, 2006 at 02:00:25PM -0800, Chris Wright wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> ------------------
> 
> From: Shaohua Li <shaohua.li@intel.com>
> 
> IA32 manual says if micorcode update's size is 0, then the size is
> default size (2048 bytes). But this doesn't suggest all microcode
> update's size should be above 2048 bytes to me. We actually had a
> microcode update whose size is 1024 bytes. The patch just removed the
> check.
> 
> Backported to 2.6.18 by Daniel Drake.
> 
> Signed-off-by: Daniel Drake <dsd@gentoo.org>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> ---
>  arch/i386/kernel/microcode.c |    9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> --- linux-2.6.18.4.orig/arch/i386/kernel/microcode.c
> +++ linux-2.6.18.4/arch/i386/kernel/microcode.c
> @@ -250,14 +250,14 @@ static int find_matching_ucodes (void) 
>  		}
>  
>  		total_size = get_totalsize(&mc_header);
> -		if ((cursor + total_size > user_buffer_size) || (total_size < DEFAULT_UCODE_TOTALSIZE)) {
> +		if (cursor + total_size > user_buffer_size) {
>  			printk(KERN_ERR "microcode: error! Bad data in microcode data file\n");
>  			error = -EINVAL;
>  			goto out;
>  		}
>  
>  		data_size = get_datasize(&mc_header);
> -		if ((data_size + MC_HEADER_SIZE > total_size) || (data_size < DEFAULT_UCODE_DATASIZE)) {
> +		if (data_size + MC_HEADER_SIZE > total_size) {
>  			printk(KERN_ERR "microcode: error! Bad data in microcode data file\n");
>  			error = -EINVAL;
>  			goto out;
> @@ -460,11 +460,6 @@ static ssize_t microcode_write (struct f
>  {
>  	ssize_t ret;
>  
> -	if (len < DEFAULT_UCODE_TOTALSIZE) {
> -		printk(KERN_ERR "microcode: not enough data\n"); 
> -		return -EINVAL;
> -	}
> -
>  	if ((len >> PAGE_SHIFT) > num_physpages) {
>  		printk(KERN_ERR "microcode: too much data (max %ld pages)\n", num_physpages);
>  		return -EINVAL;
> 
> --
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
