Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbTD2WWp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 18:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbTD2WWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 18:22:45 -0400
Received: from air-2.osdl.org ([65.172.181.6]:40118 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261727AbTD2WWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 18:22:43 -0400
Date: Tue, 29 Apr 2003 15:32:44 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Gabriel Devenyi <devenyga@mcmaster.ca>
Cc: alan@redhat.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KernelJanitor: Convert remaining error returns to
 return -E Linux 2.5.68
Message-Id: <20030429153244.19c32b3c.rddunlap@osdl.org>
In-Reply-To: <200304292215.20590.devenyga@mcmaster.ca>
References: <200304292215.20590.devenyga@mcmaster.ca>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Apr 2003 22:15:20 +0000 Gabriel Devenyi <devenyga@mcmaster.ca> wrote:

| This patch applies to 2.5.68. It converts all the remaining error returns to 
| the new return -E form, this is in the KernelJanitor TODO list.
| 
| http://muss.mcmaster.ca/~devenyga/patch-linux-2.5.68-return-errors.patch
| 
| Please CC me with any discussion since I do not subscribe to lkml
| -- 

I'd have to say that it really depends on whether the caller can
handle negative return values.  Did you check/audit the callers too?

If it's a well-defined Unix/Linux error code (like s/ENOMEM/-ENOMEM/),
this should be made to work (at least in most cases).

And don't change ones that use ERR_PTR, like this:

-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;


Local variable returns of positive/negative are probably not correct...
without auditing the callers, it's hard to say.  E.g.:

-	return ErrFlag;
+	return -ErrFlag;

(same type of change in DAC960 driver)


I'm a bit suspicious of:

-	return EOF;
+	return -EOF;

and

-		return E05;
+		return -E05;

It's not just a global search & replace...


One more thing... did you build and boot that modified kernel?
If so, did it build with the same number or fewer warnings than the
unmodified version?

--
~Randy
