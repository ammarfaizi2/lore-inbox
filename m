Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129914AbQK1MA3>; Tue, 28 Nov 2000 07:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130172AbQK1MAV>; Tue, 28 Nov 2000 07:00:21 -0500
Received: from styx.suse.cz ([195.70.145.226]:62961 "EHLO kerberos.suse.cz")
        by vger.kernel.org with ESMTP id <S129914AbQK1MAC>;
        Tue, 28 Nov 2000 07:00:02 -0500
Date: Tue, 28 Nov 2000 09:59:24 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Rusty Russell <rusty@linuxcare.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0" from drivers/ide (test11)
Message-ID: <20001128095924.C356@suse.cz>
In-Reply-To: <20001124224018.A5173@suse.cz> <20001128031933.52DB981F5@halfway.linuxcare.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001128031933.52DB981F5@halfway.linuxcare.com.au>; from rusty@linuxcare.com.au on Tue, Nov 28, 2000 at 02:19:23PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2000 at 02:19:23PM +1100, Rusty Russell wrote:
> In message <20001124224018.A5173@suse.cz> you write:
> > On Thu, Nov 23, 2000 at 10:01:53PM +1100, Rusty Russell wrote:
> > > What irritates about these monkey-see-monkey-do patches is that if I
> > > initialize a variable to NULL, it's because my code actually relies on
> > > it; I don't want that information eliminated.
> > 
> > Yes, but if it generates a bigger (== worse) binary?
> 
> We're talking about a few bytes, here.  If you're prepared to make my
> code less clear to save bytes, you can do much better than that...

Perhaps in your case you had just an

int a = 0;

then it's really just a few bytes, but many sources have for example

int a[1024] = { 0, 0, /* .... */ };

Which in turn is a big wastage.

On the other hand, if you save "just" a few bytes in every driver, in a
way that is safe and simple (and commenting out the = 0 is a safe way),
you get a lot of space saved in the sum.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
