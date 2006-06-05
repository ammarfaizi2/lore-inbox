Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751108AbWFEOKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWFEOKt (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 10:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWFEOKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 10:10:49 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58385 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751108AbWFEOKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 10:10:48 -0400
Date: Mon, 5 Jun 2006 15:10:41 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
        Patrick Caulfield <pcaulfie@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>, davej@redhat.com,
        David Teigland <teigland@redhat.com>
Subject: Re: 2.6.18 -mm merge plans -- GFS
Message-ID: <20060605141041.GD18976@flint.arm.linux.org.uk>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Patrick Caulfield <pcaulfie@redhat.com>,
	Steven Whitehouse <swhiteho@redhat.com>, davej@redhat.com,
	David Teigland <teigland@redhat.com>
References: <20060604135011.decdc7c9.akpm@osdl.org> <1149514730.30024.133.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149514730.30024.133.camel@pmac.infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2006 at 02:38:50PM +0100, David Woodhouse wrote:
> You didn't mention GFS2 either -- is that ready to go upstream?
> It contains this in its user<->kernel communication (whitespace sic)...
> 
> /* struct passed to the lock write */
> struct dlm_lock_params {
>        __u8 mode;
>        __u16 flags;
>        __u32 lkid;
>        __u32 parent;
>        __u8 namelen;

Hmm.  This is going to be subject to random compiler padding.  It would
be much better to have:

	__u8 mode;
	__u8 namelen;
	__u16 flags;
	__u32 lkid;
	__u32 parent;

which should be less subject to compiler padding.

> struct dlm_write_request {
>        __u32 version[3];
>        __u8 cmd;

Ditto - though maybe following this by:

	__u8 unused[3];

would be a sane solution.

> struct dlm_lock_result {
>        __u32 length;
>        void __user * user_astaddr;
>        void __user * user_astparam;
>        struct dlm_lksb __user * user_lksb;
>        struct dlm_lksb lksb;
>        __u8 bast_mode;

Ditto.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
