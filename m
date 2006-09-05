Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161010AbWIETUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161010AbWIETUA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 15:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161009AbWIETT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 15:19:59 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:6467 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161010AbWIETT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 15:19:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jk3EZPZpW53Zr3B46vf0D42QJhWdBOymR97TW2IHpjC8UWtGTU7C1jCM83VMOEtN28OtwxifyBI9zbe1/66eH9pV11Yy8lrJruTDbBY4AzHPEF0W0O4Li7X+0lFDj3ha+96osFXXOqtgfTKv0SCLYd81R51KxVkw8L7Ch/tNea0=
Message-ID: <a44ae5cd0609051219p5962b62ek8dd695d3f3c88fa4@mail.gmail.com>
Date: Tue, 5 Sep 2006 12:19:57 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Stefan Richter" <stefanr@s5r6.in-berlin.de>
Subject: Re: 2.6.18-rc5-mm1 + all hotfixes -- INFO: possible recursive locking detected
Cc: "Andrew Morton" <akpm@osdl.org>, linux1394-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>,
       "Herbert Xu" <herbert@gondor.apana.org.au>
In-Reply-To: <44FDC9F5.3090605@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0609051037k47d1ad7dsa8276dc0cec416bf@mail.gmail.com>
	 <20060905111306.80398394.akpm@osdl.org>
	 <a44ae5cd0609051116k6c236ba6xa2fd0119708a6950@mail.gmail.com>
	 <44FDC9F5.3090605@s5r6.in-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/06, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> Miles Lane wrote:
> > On 9/5/06, Andrew Morton <akpm@osdl.org> wrote:
> >> On Tue, 5 Sep 2006 10:37:51 -0700
> >> "Miles Lane" <miles.lane@gmail.com> wrote:
> >>
> >>> ieee1394: Node changed: 0-01:1023 -> 0-00:1023
> >>> ieee1394: Node changed: 0-02:1023 -> 0-01:1023
> >>> ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[0080880002103eae]
> >>>
> >>> =============================================
> >>> [ INFO: possible recursive locking detected ]
> >>> 2.6.18-rc5-mm1 #2
> >>> ---------------------------------------------
> >>> knodemgrd_0/2321 is trying to acquire lock:
> >>>  (&s->rwsem){----}, at: [<f8958897>] nodemgr_probe_ne+0x311/0x38d [ieee1394]
> >>>
> >>> but task is already holding lock:
> >>>  (&s->rwsem){----}, at: [<f8959078>] nodemgr_host_thread+0x717/0x883 [ieee1394]
>
> How often does this happen?

It seems to happen each time I plug in my JVC MiniDV camera (model GR-DVL9800U).

> >> That's a 1394 glitch, possibly introduced by git-ieee1394.patch.
> >
> > Would you like me to verify that removing the patch fixes it, or
> > should I wait for the 2.6.18-rc6-mm1 tree?
>
> My patches
> "ieee1394: nodemgr: switch to kthread api, replace reset semaphore" and
> "ieee1394: nodemgr: convert nodemgr_serialize semaphore to mutex"
> may be relevant. They are included in git-ieee1394.patch.
>
> Could you revert them individually and test? It should be possible to
> just "patch -p1 -R < ...." the following patchfiles:
> http://me.in-berlin.de/~s5r6/linux1394/updates/2.6.18-rc5/patches/119-ieee1394-nodemgr-convert-nodemgr_serialize-semaphore-to-mutex.patch
> If the problem persists, also revert
> http://me.in-berlin.de/~s5r6/linux1394/updates/2.6.18-rc5/patches/118-ieee1394-nodemgr-switch-to-kthread-api--replace-reset-semaphore.patch
>
> If that does not help, install them again and unapply all ieee1394
> patches from -mm. If you have the time.

I am setting up to test with the first patch removed.  The patch
doesn't apply cleanly, but I suspect this is no big deal.

patch -p1 -R < /home/miles/119-ieee1394-nodemgr-convert-nodemgr_serialize-semaphore-to-mutex.patch
patching file drivers/ieee1394/nodemgr.c
Hunk #2 succeeded at 1630 (offset 9 lines).
Hunk #3 succeeded at 1659 (offset 9 lines).
Hunk #4 succeeded at 1677 (offset 9 lines).
