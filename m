Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290840AbSBLJA5>; Tue, 12 Feb 2002 04:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290839AbSBLJAr>; Tue, 12 Feb 2002 04:00:47 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:22287 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S290837AbSBLJAf>; Tue, 12 Feb 2002 04:00:35 -0500
Date: Tue, 12 Feb 2002 10:00:32 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Hal Duston <hald@sound.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Input w/2.5.3-dj3
Message-ID: <20020212100032.C1210@suse.cz>
In-Reply-To: <Pine.GSO.4.10.10202111857040.7585-100000@sound.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.10.10202111857040.7585-100000@sound.net>; from hald@sound.net on Mon, Feb 11, 2002 at 07:00:47PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 11, 2002 at 07:00:47PM -0600, Hal Duston wrote:

> OK, i8042_direct=1 fixed things for my wrong keys issue.
> atkbd_set=3 didn't appear to make any difference (I think)
> I'm using atkbd_set=2 currently, but I think =3 worked as well.

Wow, this must be a crazy machine. This means it's using Set1 by default
on the keyboard and has translation switched off in the i8042. Hmm, I'll
have to add a way to detect this ... can you try the attached patch to
see if it fixes your problem? With this patch, you shouldn't need to add
"i8042_direct=1" as it should detect the case automatically. If it
doesn't, please send me the log with this change and without the option
again.

-- 
Vojtech Pavlik
SuSE Labs

--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="i8042-autounxl.diff"

--- i8042.c	Tue Feb 12 09:57:13 2002
+++ i8042.new	Tue Feb 12 09:56:42 2002
@@ -492,6 +492,9 @@
 	if (i8042_direct)
 		i8042_ctr &= ~I8042_CTR_XLATE;
 
+	if (~i8042_ctr & I8042_CTR_XLATE)
+		i8042_direct = 1;
+
 /*
  * Write CTR back.
  */

--rS8CxjVDS/+yyDmU--
