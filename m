Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbTEYRVw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 13:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263668AbTEYRVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 13:21:52 -0400
Received: from netmail02.services.quay.plus.net ([212.159.14.221]:31417 "HELO
	netmail02.services.quay.plus.net") by vger.kernel.org with SMTP
	id S263653AbTEYRVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 13:21:50 -0400
From: "Riley Williams" <Riley@Williams.Name>
To: "Matt Mackall" <mpm@selenic.com>,
       "Linus Torvalds" <torvalds@transmeta.com>
Cc: "Ben Collins" <bcollins@debian.org>, "Patrick Mochel" <mochel@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Resend [PATCH] Make KOBJ_NAME_LEN match BUS_ID_SIZE
Date: Sun, 25 May 2003 18:25:12 +0100
Message-ID: <BKEGKPICNAKILKJKMHCACEDDEBAA.Riley@Williams.Name>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20030525155102.GN23715@waste.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt.

 >> How about just adding a sane
 >>
 >>	int copy_string(char *dest, const char *src, int len)
 >>	{
 >>		int size;
 >>
 >>		if (!len)
 >>			return 0;
 >>		size = strlen(src);
 >>		if (size >= len)
 >>			size = len-1;
 >>		memcpy(dest, src, size);
 >>		dest[size] = '\0';
 >>		return size;
 >>	}

 > The return value here isn't particularly useful. The OpenBSD
 > strlcpy/strlcat variant tell you how big the result should have been
 > so that you can realloc if need be.

Something along the lines of...

	int strlcpy(char *tgt, char *src, int len)
	{
		int size = strlen(src);

		if (size < len)
			strcpy(tgt, src);
		else {
			memcpy(tgt, src, len-1);
			tgt[len] = '\0';
		}
		return size;
	}

...reindented according to standards (which I don't have to hand).

Best wishes from Riley.
---
 * Nothing as pretty as a smile, nothing as ugly as a frown.

---
Outgoing mail is certified Virus Free.
Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.483 / Virus Database: 279 - Release Date: 19-May-2003

