Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbRAEBDC>; Thu, 4 Jan 2001 20:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129460AbRAEBCw>; Thu, 4 Jan 2001 20:02:52 -0500
Received: from c-025.static.AT.KPNQwest.net ([193.154.188.25]:48118 "EHLO
	stefan.sime.com") by vger.kernel.org with ESMTP id <S129387AbRAEBCs>;
	Thu, 4 Jan 2001 20:02:48 -0500
Date: Fri, 5 Jan 2001 02:01:37 +0100
From: Stefan Traby <stefan@hello-penguin.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Stefan Traby <stefan@hello-penguin.com>,
        Daniel Phillips <phillips@innominate.de>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
Message-ID: <20010105020137.A1396@stefan.sime.com>
Reply-To: Stefan Traby <stefan@hello-penguin.com>
In-Reply-To: <Pine.LNX.4.30.0101031253130.6567-100000@springhead.px.uk.com> <Pine.LNX.4.21.0101031325270.1403-100000@duckman.distro.conectiva> <3A5352ED.A263672D@innominate.de> <20010104192104.C2034@redhat.com> <20010104220821.B775@stefan.sime.com> <20010104224946.C1290@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010104224946.C1290@redhat.com>; from sct@redhat.com on Thu, Jan 04, 2001 at 10:49:46PM +0000
Organization: Stefan Traby Services && Consulting
X-Operating-System: Linux 2.4.0-prerelease-fijiji2 (i686)
X-APM: 100% 200 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2001 at 10:49:46PM +0000, Stephen C. Tweedie wrote:
> > I think any other action (only replaying on rw mount and presenting
> > a broken filesystem on ro) is quite fatal, at least if I think of
> > a replay on -remount,rw :)
> 
> Correct.
> 
> > Also, an unconditional hidden replay even if "ro" is specified is not nice.
> 
> > This is especially critical on root filesystem
> 
> In what way?  A root fs readonly mount is usually designed to prevent
> fsck can run without the filesystem being volatile.  That's the only

There are people out that say that readonly mount was
initially designed to behave as physically read only.
fsck was a wanted side-effect...
And trust me, most people think so before dialing
with a journaled filesystem. This was discussed
to death on the reiserFS list.

Clearly the definition of "ro" is weak, does it mean media or
filesystem view ? It's even weak on lower levels: There are
also disks out there that write even if physical write-protection
is enabled (for example auto-remapping after an ECC-recovery read).

Anyway, it is "especially" critical on the root filesystem because the
authors of filesystems can't support two ro states on boot.

Reiserfs allowed  -oro,noreplay.

Please tell me how to specify "noreplay" for the initial "/" mount
:)

Yes, I think that the journal is an integral part of the filesystem.
But this has nothing to do with forcing a write on "ro" mounts, which
I interpret as design bug. (ro,noreplay is also a kind of design bug,
everything except a virtual replay under physical ro conditions looks
like a design bug to me because it breaks user expectations either
by writing on "ro" or by giving an invalid view by "noreplay")

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
