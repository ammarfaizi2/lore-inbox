Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135643AbRAJRFt>; Wed, 10 Jan 2001 12:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135664AbRAJRFj>; Wed, 10 Jan 2001 12:05:39 -0500
Received: from c-025.static.AT.KPNQwest.net ([193.154.188.25]:22260 "EHLO
	stefan.sime.com") by vger.kernel.org with ESMTP id <S135643AbRAJRFc>;
	Wed, 10 Jan 2001 12:05:32 -0500
Date: Wed, 10 Jan 2001 18:03:53 +0100
From: Stefan Traby <stefan@hello-penguin.com>
To: "Vladimir V. Saveliev" <vs@namesys.botik.ru>
Cc: Chris Mason <mason@suse.com>, Marc Lehmann <pcg@goof.com>,
        reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] major security bug in reiserfs (may affect SuSE Linux)
Message-ID: <20010110180353.B2101@stefan.sime.com>
Reply-To: Stefan Traby <stefan@hello-penguin.com>
In-Reply-To: <75150000.979093424@tiny> <3A5C8780.5B02EC8A@namesys.botik.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5C8780.5B02EC8A@namesys.botik.ru>; from vs@namesys.botik.ru on Wed, Jan 10, 2001 at 07:02:08PM +0300
Organization: Stefan Traby Services && Consulting
X-Operating-System: Linux 2.4.0-fijiji0 (i686)
X-APM: 100% 400 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 07:02:08PM +0300, Vladimir V. Saveliev wrote:

> Hmm, wouldn't it make existing long named files unreachable?

This is not of primary interest. Security first.
The only way to recover those files secure without risking a crash
is maybe to let fsck rename those long files after the patch.

Before the 255-limit-patch a rename(2) may work, but without a directory
lookup from userland; quite hard to do.

When I played with Marc's case, I needed to reboot 2 times because I
tried to use tab-expansion on bash to get the filename; which caused
a machine freeze.

perl -e 'rmdir "x" x 768' worked,

or under bash

rmdir <ESC>768x  should work, too.

Really, the 255-limit is essential as long as "struct dirent/64" has
d_name[255] hard coded. Somebody should send Drepper a patch;
I did not understand why he accepted a NAME_MAX of 4032 patch for
reiserfs while knowing the hardcoded dirent limit.


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
