Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262553AbVAQSnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262553AbVAQSnE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 13:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262467AbVAQSnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 13:43:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41437 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262844AbVAQSdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 13:33:05 -0500
Date: Mon, 17 Jan 2005 18:33:04 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/13] FAT: IS_BADCHAR/IS_REPLACECHR/IS_SKIPCHAR cleanup
Message-ID: <20050117183304.GT26051@parcelfarce.linux.theplanet.co.uk>
References: <87pt04oszi.fsf@devron.myhome.or.jp> <87llasosxu.fsf@devron.myhome.or.jp> <87hdlgoswe.fsf_-_@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87hdlgoswe.fsf_-_@devron.myhome.or.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 02:41:05AM +0900, OGAWA Hirofumi wrote:
> +static inline wchar_t vfat_bad_char(wchar_t w)
> +{
> +	return (w < 0x0020)
> +	    || (w == 0x002A) /* * */	|| (w == 0x003F) /* ? */
> +	    || (w == 0x003C) /* < */	|| (w == 0x003E) /* > */
> +	    || (w == 0x007C) /* | */	|| (w == 0x0022) /* " */
> +	    || (w == 0x003A) /* : */	|| (w == 0x002F) /* / */
> +	    || (w == 0x005C);/* \ */
> +}

Ugh...  What's wrong with comparison to '*', '<', etc.?  All values are
below 0x80, so signedness of char doesn't matter and when they get
promoted to int, they will give you the values you want...

> +static inline wchar_t vfat_replace_char(wchar_t w)
> +{
> +	return (w == 0x005B) /* [ */	|| (w == 0x005D) /* ] */
> +	    || (w == 0x003B) /* ; */	|| (w == 0x002C) /* , */
> +	    || (w == 0x002B) /* + */	|| (w == 0x003D);/* = */
> +}

Ditto.
