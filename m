Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVA3Sao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVA3Sao (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 13:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVA3San
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 13:30:43 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:2834 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261760AbVA3Saf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 13:30:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=EgCW1FoyUvpT+q+5qmRJL0Xt8HSun13jSDIlctGXAIZx4lO3VBx94Z4nhm8jaGzq1LdFnXiTJ62hTBUW9PSOw8OBYqOpdUnG9j2Xf39X5SqytBJveZlLQUmqRKNPYJza3nDpE6GwGK+ymqRDH2aHtqqAQdY/0a1bMIiVbKIkptA=
Message-ID: <5a2cf1f605013010305f8270de@mail.gmail.com>
Date: Sun, 30 Jan 2005 19:30:35 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
Reply-To: jerome lacoste <jerome.lacoste@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 1/1] fix syscallN() macro errno value checking for i386
Cc: blaisorblade@yahoo.it, akpm@osdl.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
In-Reply-To: <200501301800.22706.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <20050129010145.1C42F8C9E4@zion> <200501301800.22706.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jan 2005 18:00:22 +0100, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sünnavend 29 Januar 2005 02:01, blaisorblade@yahoo.it wrote:
> >
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> > Cc: David Howells <dhowells@redhat.com>
> >
> > The errno values which are visible for userspace are actually in the range
> > -1 - -129, not until -128 (): this value was added:
> >
> > #define       EKEYREJECTED    129     /* Key was rejected by service */
> >
> > And this would break ucLibc (for what I heard).
> >
> > This is just a quick-fix, because putting a macro inside errno.h instead of
> > having it copied in two places would be probably nicer.
> 
> Yes. Note that your patch only fixes the bug on i386. The code has been
> copied to many other architectures, and some of them have been updated
> less recently and are checking for values lower than 128. There should
> really be a way to keep them all in sync.


what about something along?

#define EKEYNEXT    130     /* key counter */

and 

 if ((unsigned long)(res) >= (unsigned long)(-EKEYNEXT)) {

JL
