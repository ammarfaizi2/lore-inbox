Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269852AbTGKJfh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 05:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269855AbTGKJfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 05:35:37 -0400
Received: from users.linvision.com ([62.58.92.114]:45776 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id S269852AbTGKJfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 05:35:33 -0400
Date: Fri, 11 Jul 2003 11:50:01 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ben Collins <bcollins@debian.org>, Patrick Mochel <mochel@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Resend [PATCH] Make KOBJ_NAME_LEN match BUS_ID_SIZE
Message-ID: <20030711115001.B17007@bitwizard.nl>
References: <20030525000701.GG504@phunnypharm.org> <Pine.LNX.4.44.0305242045050.1666-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305242045050.1666-100000@home.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 24, 2003 at 08:52:53PM -0700, Linus Torvalds wrote:
> How about just adding a sane
> 
> 	int copy_string(char *dest, const char *src, int len)
> 	{
> 		int size;
> 
> 		if (!len)
> 			return 0;
> 		size = strlen(src);
> 		if (size >= len)
> 			size = len-1;
> 		memcpy(dest, src, size);
> 		dest[size] = '\0';
> 		return size;
> 	}

Just catching up... 

Most people will think: "But that's not efficient!" he first
determines the size using strlen, and only then does he start a
memcpy.

In fact most modern processors priming the cache and then doing the
copy is noticably faster or just a teeny little bit slower.

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* I didn't say it was your fault. I said I was going to blame it on you. *
