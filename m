Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314687AbSD1Wva>; Sun, 28 Apr 2002 18:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314690AbSD1Wv3>; Sun, 28 Apr 2002 18:51:29 -0400
Received: from dsl-213-023-040-044.arcor-ip.net ([213.23.40.44]:60045 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314687AbSD1Wv3>;
	Sun, 28 Apr 2002 18:51:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Robert Love <rml@tech9.net>,
        Emmanuel Michon <emmanuel_michon@realmagic.fr>
Subject: Re: spinlocking between user context / tasklet / tophalf question
Date: Sun, 28 Apr 2002 00:52:08 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7wwuuu4zam.fsf@avalon.france.sdesigns.com> <1019848780.2045.617.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E171b32-0001QJ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Friday 26 April 2002 21:19, Robert Love wrote:
> On Fri, 2002-04-26 at 04:52, Emmanuel Michon wrote:
> > 2. What is the reality behind: ``things which sleep'', is it really a problem
> > to use copy_from_user/copy_to_user holding a spinlock?
> 
> Yes, they sleep.

Well, I think he really wanted to know why it's bad.  Emmanuel, suppose process A
takes spinlock S then sleeps.  Process B is then scheduled and tries to acquire
S - bang, deadlock: Process A can't release the spinlock because it's sleeping.

Let alone the fact that another CPU trying to acquire S is going to end up
stalled potentially many milliseconds before process A wakes up again and
releases the spinlock.

-- 
Daniel
