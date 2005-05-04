Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVEDSwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVEDSwz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 14:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVEDSwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 14:52:55 -0400
Received: from khc.piap.pl ([195.187.100.11]:27652 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S261385AbVEDSwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 14:52:51 -0400
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Valdis.Kletnieks@vt.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] update SubmittingPatches to clarify attachment
 policy
References: <20050504170156.87F67CE5@kernel.beaverton.ibm.com>
	<200505041716.j44HGPbV016851@turing-police.cc.vt.edu>
	<1115227516.22718.4.camel@localhost>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 04 May 2005 20:52:45 +0200
In-Reply-To: <1115227516.22718.4.camel@localhost> (Dave Hansen's message of
 "Wed, 04 May 2005 10:25:16 -0700")
Message-ID: <m364xysu0y.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> +Many maintainers will now accept patches submitted to them as
> +text/plain attachments.  Many mailers quote these attachements in the
> +same way that they do for inline patches.  But, some maintainers still
> +prefer inlines and they are certainly the safest bet.

There is MIME "Content-Disposition: inline".
Personally I think it's at least as good as plain text - it's MIME
attachment (you can extract automatically, you have well-defined patch
boundaries, original file name etc.) _and_ mail readers are supposed to
(and do) display such attachments as normal message parts.

The message is readable with MIME-unaware readers (scripts etc.) as well.

Such attachment (raw message data) looks like:

From: xxx@yyy
To: lkml
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
--=-=-=

Normal message text etc.

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=xxx.patch

--- linux-2.6/xxx.c 25 May 2003 22:13:37
+++ linux-2.6/xxx.c 25 May 2003 22:13:38
the rest of patch text

--=-=-=--

> +code.  If you must use an attachment,

Nearly no one "must" use attachments. I can only think of people using
broken mail servers ("corporate servers").

> verify that it has no
> +Content-Type-Encoding.

Content-Transfer-Encoding.

I'd say "verify that it's binary-encoded - quoted-printable and base64
encodings are not permitted".

I.e., it's perfectly fine to specify "Content-Transfer-Encoding: 7bit"
(or "8bit" or possibly "binary", though I don't exactly know the
difference between "8bit" and "binary").

>  A MIME attachment also takes Linus a bit more
> +time to process, decreasing the likelihood of your MIME-attached
> +change being accepted.

I don't think so. Badly formatted MIME attachments, sure. I'd be
surprised if Linus applies them at all.

>  Exception:  If your mailer is mangling patches then someone may ask
> -you to re-send them using MIME.
> +you to re-send them compressed or using other MIME encodings.

Rather: "... someone may ask you to re-send them as properly encoded
MIME attachments".


In fact I'd encourage using binary-encoded inlined MIME attachments
at all times, with non-MIME 7bit or 8bit plain text being accepted
as secondary format.
-- 
Krzysztof Halasa
