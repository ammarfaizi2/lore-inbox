Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263164AbTIVOa0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 10:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbTIVOaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 10:30:25 -0400
Received: from yankee.rb.xcalibre.co.uk ([217.8.240.35]:51660 "EHLO
	yankee.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id S263164AbTIVOaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 10:30:21 -0400
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair J Strachan <alistair@devzero.co.uk>
To: viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: 2.6.0-test5-mm4
Date: Mon, 22 Sep 2003 15:29:57 +0100
User-Agent: KMail/1.5.9
References: <20030922013548.6e5a5dcf.akpm@osdl.org> <200309221317.42273.alistair@devzero.co.uk> <20030922134813.GF7665@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030922134813.GF7665@parcelfarce.linux.theplanet.co.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200309221529.57836.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 22 September 2003 14:48, you wrote:
> On Mon, Sep 22, 2003 at 01:17:42PM +0100, Alistair J Strachan wrote:
> > One possible explanation is that I have devfs compiled into my kernel. I
> > do not, however, have it automatically mounting on boot. It overlays /dev
> > (which is populated with original style device nodes) after INIT has
> > loaded.
>
> Amazingly idiotic typo.  And yes, it gets hit only if devfs is configured.
>
> diff -u B5-real32/init/do_mounts.h B5-current/init/do_mounts.h
> --- B5-real32/init/do_mounts.h	Sun Sep 21 21:22:33 2003
> +++ B5-current/init/do_mounts.h	Mon Sep 22 09:41:21 2003
> @@ -53,7 +53,7 @@
>  static inline u32 bstat(char *name)
>  {
>  	struct stat64 stat;
> -	if (!sys_stat64(name, &stat) != 0)
> +	if (sys_stat64(name, &stat) != 0)
>  		return 0;
>  	if (!S_ISBLK(stat.st_mode))
>  		return 0;
> @@ -65,7 +65,7 @@
>  static inline u32 bstat(char *name)
>  {
>  	struct stat stat;
> -	if (!sys_newstat(name, &stat) != 0)
> +	if (sys_newstat(name, &stat) != 0)
>  		return 0;
>  	if (!S_ISBLK(stat.st_mode))
>  		return 0;

Thanks for that. It's working fine now.

Cheers,
Alistair.
