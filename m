Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129784AbQLGObs>; Thu, 7 Dec 2000 09:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130006AbQLGObi>; Thu, 7 Dec 2000 09:31:38 -0500
Received: from [62.172.234.2] ([62.172.234.2]:50230 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S129784AbQLGOb3>;
	Thu, 7 Dec 2000 09:31:29 -0500
Date: Thu, 7 Dec 2000 14:03:01 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Szabolcs Szakacsits <szaka@f-secure.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Broken NR_RESERVED_FILES
In-Reply-To: <Pine.LNX.4.30.0012071525540.5455-100000@fs129-190.f-secure.com>
Message-ID: <Pine.LNX.4.21.0012071359210.970-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Szabolcs Szakacsits wrote:
> On Thu, 7 Dec 2000, Tigran Aivazian wrote:
> > On Thu, 7 Dec 2000, Szabolcs Szakacsits wrote:
> > > Reserved fd's for superuser doesn't work.
> > It does actually work,
> 
> What do you mean under "work"? I meant user apps are able to
> exhaust fd's completely and none is left for superuser.

really? how did you manage to do that? On a 2.4.0-test12-pre7 system I
cannot reproduce the behaviour you describe. I.e. at least
NR_RESERVED_FILES (which I agree with you should be increased!) are left
to superuser processes whilst the user processes are denied.

How exactly are you reproducing this? I wrote a simple while (1)
{open("/dev/null", 0); } program and run many instances of it as user. At
some stage user starts failing but superuser happily draws from the
freelist. Of course, the superuser cannot start complex programs which
require many descriptos but that is entirely the issues of
NR_RESERVED_FILES being too small on which I totally agree with you.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
