Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281765AbRKZPOB>; Mon, 26 Nov 2001 10:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281766AbRKZPNv>; Mon, 26 Nov 2001 10:13:51 -0500
Received: from ns.suse.de ([213.95.15.193]:57106 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281765AbRKZPNl> convert rfc822-to-8bit;
	Mon, 26 Nov 2001 10:13:41 -0500
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] net/802/Makefile
In-Reply-To: <20011126140645.B3014@suse.de> <20011126142425.B27554@suse.de>
X-Yow: I selected E5...  but I didn't hear ``Sam the Sham and the Pharaohs''!
From: Andreas Schwab <schwab@suse.de>
Date: 26 Nov 2001 16:13:36 +0100
In-Reply-To: <20011126142425.B27554@suse.de> (Olaf Hering's message of "Mon, 26 Nov 2001 14:24:25 +0100")
Message-ID: <jewv0d1s67.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.1.30
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering <olh@suse.de> writes:

|> On Mon, Nov 26, Olaf Hering wrote:
|> 
|> > Hi,
|> > 
|> > the build stops when cl2llc.c has no write permissions.
|> 
|> Here is a better version, suggested by Rik:
|> 
|> diff -urN linuxppc_2_4/net/802/Makefile.broken
|> linuxppc_2_4/net/802/Makefile
|> --- linuxppc_2_4/net/802/Makefile.broken        Mon Nov 26 13:28:56 2001
|> +++ linuxppc_2_4/net/802/Makefile       Mon Nov 26 14:22:55 2001
|> @@ -57,4 +57,6 @@
|>  include $(TOPDIR)/Rules.make
|>  
|>  cl2llc.c: cl2llc.pre
|> +       touch cl2llc.c
|> +       chmod u+w cl2llc.c
|>         sed -f ./pseudo/opcd2num.sed cl2llc.pre >cl2llc.c

How about this:

@@ -57,4 +57,5 @@
 include $(TOPDIR)/Rules.make
 
 cl2llc.c: cl2llc.pre
+	rm -f cl2llc.c
 	sed -f ./pseudo/opcd2num.sed cl2llc.pre >cl2llc.c
 
 
Andreas.

-- 
Andreas Schwab                                  "And now for something
Andreas.Schwab@suse.de				completely different."
SuSE Labs, SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
