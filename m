Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129381AbRB0OJP>; Tue, 27 Feb 2001 09:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRB0OJF>; Tue, 27 Feb 2001 09:09:05 -0500
Received: from itaipu.nitnet.com.br ([200.255.111.241]:48911 "HELO
	itaipu.nitnet.com.br") by vger.kernel.org with SMTP
	id <S129381AbRB0OIw>; Tue, 27 Feb 2001 09:08:52 -0500
Date: Tue, 27 Feb 2001 11:08:48 -0300
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Re: CPU name for "pure" i386 missing
Message-ID: <20010227110848.A1000@flower.cesarb>
In-Reply-To: <20010226214900.A11142@flower.cesarb>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010226214900.A11142@flower.cesarb>; from cesarb on Mon, Feb 26, 2001 at 09:49:00PM -0300
From: Cesar Eduardo Barros <cesarb@nitnet.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've made a patch to fix the problem. I've not even compiled it yet (I might do
it later).


--- linux-2.4.2.orig/arch/i386/kernel/setup.c	Tue Feb 27 10:17:18 2001
+++ linux-2.4.2/arch/i386/kernel/setup.c	Tue Feb 27 11:04:54 2001
@@ -1996,6 +1996,15 @@
 	case X86_VENDOR_UNKNOWN:
 	default:
 		/* Not much we can do here... */
+		/* Check if at least it has cpuid */
+		if (c->cpuid_level == -1)
+		{
+			/* No cpuid. It must be an ancient CPU */
+			if (c->x86 == 4)
+				strcpy(c->x86_model_id, "486");
+			else if (c->x86 == 3)
+				strcpy(c->x86_model_id, "386");
+		}
 		break;
 
 	case X86_VENDOR_CYRIX:

-- 
Cesar Eduardo Barros
cesarb@nitnet.com.br
cesarb@dcc.ufrj.br
