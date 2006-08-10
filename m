Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWHJX05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWHJX05 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 19:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWHJX05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 19:26:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:3184 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932255AbWHJX04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 19:26:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dEnnEFvOnswC7G/f2C6+fszoPMtj+5N5YYpXq8fpnoi7FZMcYoVvYujFq+ZaopdfSr+Na7ep/821s1hEk6gbfUmwAyHG7pXrHvkamBZrskh/iOLpzbqHZH0Yf6Uplk+eccDVUvmiGBjt+eIAdeEeKhOPbOHzl1NmYMm71he2UKs=
Message-ID: <41840b750608101626rc9a7e18o60bcc4f855f5a9e7@mail.gmail.com>
Date: Fri, 11 Aug 2006 02:26:54 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 00/12] ThinkPad embedded controller and hdaps drivers (version 2)
Cc: "Robert Love" <rlove@rlove.org>, linux-kernel@vger.kernel.org,
       "Pavel Machek" <pavel@suse.cz>, "Jean Delvare" <khali@linux-fr.org>,
       "Greg Kroah-Hartman" <gregkh@suse.de>,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <20060810131820.23f00680.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1155203330179-git-send-email-multinymous@gmail.com>
	 <acdcfe7e0608100646s411f57ccse54db9fe3cfde3fb@mail.gmail.com>
	 <20060810131820.23f00680.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/06, Andrew Morton <akpm@osdl.org> wrote:
> This situation is still a concern.  From where did this additional register
> information come?
>
> Was it reverse-engineered?  If so, by whom and how can we satisfy ourselves
> of this?
>
> Was it from published documents?

Here's a more detailed explanation:

All the low level LPC register access is publicly documented in the
manual of the embedded controller. See [1] and in particular [2]. The
submitted thinkpad_ec code just follows these specs (very defensively
with and a lot of extra status checks, because some EC hangs were
reported in older versions). The only remaining information is about
the accelerometer-specific commands implemented by the firmware; the
public APS spec [3] and the mainline code based on this already
contain most of the this information, and a few corrections and
extentions were gleaned from the reverse-engineered the firmware code
[4]. If case you're wondering about the "opaque" function,
hdaps_check_ec(), then note that it's just code from the original
hdaps driver (following [3]) that's translated to use thinkpad_ec
instead of direct IO port access.


> Was it improperly obtained from NDA'ed documentation?

Absolutely not. I've never signed any NDA remotely related to this.
(and why I do so when the above sources already contain all the needed
information?)

BTW, I can't help wondering: do you have a similarly detailed account
for an appreciable fraction of the driver code in mainline?


> So hm.  We're setting precedent here and we need Linus around to resolve
> this.  Perhaps we can ask "Shem" to reveal his true identity to Linus (and
> maybe me) privately and then we proceed on that basis.

Sure, we can do this. Actually I've alredy e-mailed Linus to this
effect several days ago, before realizing he's off-line.


> "each of the Signed-off-by:ers should know the identity of the others".

How following the DCO's chain-of-trust model?

--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -296,7 +296,7 @@ can certify the below:

         (c) The contribution was provided directly to me by some other
             person who certified (a), (b) or (c) and I have not modified
-            it.
+            it, and the legal identity of that person is known to me.

        (d) I understand and agree that this project and the contribution
            are public and that a record of the contribution (including all


  Shem

[1]http://thinkwiki.org/wiki/Renesas_H8S/2161BV and in particular
[2]http://documentation.renesas.com/eng/products/mpumcu/rej09b0300_2140bhm.pdf
[3]http://www.almaden.ibm.com/cs/people/marksmith/tpaps.html
[4]http://forum.thinkpads.com/viewtopic.php?t=20958
