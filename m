Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129773AbRADVJf>; Thu, 4 Jan 2001 16:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129939AbRADVJZ>; Thu, 4 Jan 2001 16:09:25 -0500
Received: from c-025.static.AT.KPNQwest.net ([193.154.188.25]:31222 "EHLO
	stefan.sime.com") by vger.kernel.org with ESMTP id <S129773AbRADVJM>;
	Thu, 4 Jan 2001 16:09:12 -0500
Date: Thu, 4 Jan 2001 22:08:21 +0100
From: Stefan Traby <stefan@hello-penguin.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Daniel Phillips <phillips@innominate.de>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
Message-ID: <20010104220821.B775@stefan.sime.com>
Reply-To: Stefan Traby <stefan@hello-penguin.com>
In-Reply-To: <Pine.LNX.4.30.0101031253130.6567-100000@springhead.px.uk.com> <Pine.LNX.4.21.0101031325270.1403-100000@duckman.distro.conectiva> <3A5352ED.A263672D@innominate.de> <20010104192104.C2034@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010104192104.C2034@redhat.com>; from sct@redhat.com on Thu, Jan 04, 2001 at 07:21:04PM +0000
Organization: Stefan Traby Services && Consulting
X-Operating-System: Linux 2.4.0-prerelease-fijiji2 (i686)
X-APM: 100% 200 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2001 at 07:21:04PM +0000, Stephen C. Tweedie wrote:

> ext3 does the recovery automatically during mount(8), so user space
> will never see an unrecovered filesystem.  (There are filesystem flags
> set by the journal code to make sure that an unrecovered filesystem
> never gets mounted by a kernel which doesn't know how to do the
> appropriate recovery.)

I did not follow the ext3 development recently, how did you solve
the "read-only mount(2) (optionally on write protected media)" issue ?

Does the mount fail, or does the code virtually replays (without writing)
only ?

I think any other action (only replaying on rw mount and presenting
a broken filesystem on ro) is quite fatal, at least if I think of
a replay on -remount,rw :)

Also, an unconditional hidden replay even if "ro" is specified is not nice.

This is especially critical on root filesystem, because there is IMHO
no way to specify mount arguments to the "/" mount, except ro/rw.

-- 

  ciao - 
    Stefan

"     ( cd /lib ; ln -s libBrokenLocale-2.2.so libNiedersachsen.so )     "
    
Stefan Traby                Linux/ia32               fax:  +43-3133-6107-9
Mitterlasznitzstr. 13       Linux/alpha            phone:  +43-3133-6107-2
8302 Nestelbach             Linux/sparc       http://www.hello-penguin.com
Austria                                    mailto://st.traby@opengroup.org
Europe                                   mailto://stefan@hello-penguin.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
