Return-Path: <linux-kernel-owner+w=401wt.eu-S1751529AbWLNFXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbWLNFXd (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 00:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbWLNFXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 00:23:33 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:27437 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbWLNFXc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 00:23:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P5k178rIuE+gfXjFVr/mYRQYxXZI5wG7fnzzdhNloTfhS5lfALN41T6E5qTlkzWa0Hm7oWXGEAVQfY9uu0PfLM5tmnn3ORXD97WIf2WShvhi3d/i8uiS1/Dfg+iGlTDoUJVgvWJsFN7Ix8SClNihkwpILKSHjX2P477luziqS0s=
Message-ID: <2c0942db0612132123o12d8d250rb9583a2dc1588993@mail.gmail.com>
Date: Wed, 13 Dec 2006 21:23:29 -0800
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: "Michael Bommarito" <michael.bommarito@gmail.com>
Subject: Re: [PATCH 2.6.19-git19] BUG due to bad argument to ieee80211softmac_assoc_work
Cc: "Mike Galbraith" <efault@gmx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <5b8e20700612132035w2ad90000wcaca60be5d93277d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5b8e20700612131017n1cd8aff3qbe41351435427e25@mail.gmail.com>
	 <1166070494.5853.0.camel@Homer.simpson.net>
	 <5b8e20700612132035w2ad90000wcaca60be5d93277d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/06, Michael Bommarito <michael.bommarito@gmail.com> wrote:
> Sorry, realized I might not have been clear as to what I meant!  The
> patch was attached to the bugzilla entry, but I'll attach it here as
> well.  My description of the patch itself was really as complicated as
> it gets too (just two lines, switch (void*)mac to
> &mac->assoc.work.work in
> net/ieee80211/softmac/ieee80211softmac_assoc.c), just a small bug
> while somebody was rushing through the work/delayed_work changes.

--- net/ieee80211/softmac/ieee80211softmac_assoc.c	2006-12-13
11:23:03.000000000 -0500
+++ net/ieee80211/softmac/ieee80211softmac_assoc.c	2006-12-13
11:24:26.000000000 -0500
@@ -167,7 +167,7 @@
 ieee80211softmac_assoc_notify_scan(struct net_device *dev, int
event_type, void *context)
 {
 	struct ieee80211softmac_device *mac = ieee80211_priv(dev);
-	ieee80211softmac_assoc_work((void*)mac);
+	ieee80211softmac_assoc_work(&mac->associnfo.work.work);
 }

 static void
@@ -177,7 +177,7 @@

 	switch (event_type) {
 	case IEEE80211SOFTMAC_EVENT_AUTHENTICATED:
-		ieee80211softmac_assoc_work((void*)mac);
+	        ieee80211softmac_assoc_work(&mac->associnfo.work.work);
 		break;
 	case IEEE80211SOFTMAC_EVENT_AUTH_FAILED:
 	case IEEE80211SOFTMAC_EVENT_AUTH_TIMEOUT:

Good catch, though it was already caught. See:

   http://lkml.org/lkml/2006/12/12/46

...for (basically) the same patch.

But again, good catch :-).
