Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270648AbTHLQRD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 12:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270764AbTHLQRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 12:17:03 -0400
Received: from fw1.masirv.com ([65.205.206.2]:56908 "EHLO NEWMAN.masirv.com")
	by vger.kernel.org with ESMTP id S270648AbTHLQQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 12:16:59 -0400
Message-ID: <1060651689.10867.23.camel@huykhoi>
From: Anthony Truong <Anthony.Truong@mascorp.com>
To: William Gallafent <william.gallafent@virgin.net>
Cc: Valdis.Kletnieks@vt.edu, Yoshinori Sato <ysato@users.sourceforge.jp>,
       linux kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: generic strncpy - off-by-one error
Date: Mon, 11 Aug 2003 18:28:09 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-12 at 23:54, William Gallafent wrote:

On Tue, 12 Aug 2003 Valdis.Kletnieks@vt.edu wrote:

> On Tue, 12 Aug 2003 23:50:06 +0900, Yoshinori Sato
> <ysato@users.sourceforge.jp> said:
> > -   while (count) {
> > +   while (count > 1) {
>
> Given that count is a size_t, which seems to be derived from 'unsigned
int'
> or 'unsigned long' on every platform, how are these any different?

Er, consider the case of count == 1. Fenceposts can be dangerous things.

-- 
Bill Gallafent.
-


Hello,
This is the code I got from 2.4.20:
char * strncpy(char * dest,const char *src,size_t count)
{
	char *tmp = dest;

	while (count-- && (*dest++ = *src++) != '\0')
		/* nothing */;

	return tmp;
}

I don't see any problem with this code, and if we don't need to NULL-pad
the dest string, we do not have to.  It is not in the definition of
strncpy().  So we don't need the second while {};
I'm hoping we're looking at the same thing.

Regards,
Anthony Dominic Truong.




Disclaimer: The information contained in this transmission, including any
attachments, may contain confidential information of Matsushita Avionics
Systems Corporation.  This transmission is intended only for the use of the
addressee(s) listed above.  Unauthorized review, dissemination or other use
of the information contained in this transmission is strictly prohibited.
If you have received this transmission in error or have reason to believe
you are not authorized to receive it, please notify the sender by return
email and promptly delete the transmission.


