Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129768AbQLBGBV>; Sat, 2 Dec 2000 01:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130032AbQLBGBC>; Sat, 2 Dec 2000 01:01:02 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:5124
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129768AbQLBGAu>; Sat, 2 Dec 2000 01:00:50 -0500
Date: Sat, 2 Dec 2000 18:30:21 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Steven Van Acker <deepstar@ulyssis.org>, linux-kernel@vger.kernel.org,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: ext2 directory size bug (?)
Message-ID: <20001202183021.D412@metastasis.f00f.org>
In-Reply-To: <20001202175704.B269@metastasis.f00f.org> <Pine.GSO.4.21.0012020007270.27040-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0012020007270.27040-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Dec 02, 2000 at 12:14:34AM -0500
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2000 at 12:14:34AM -0500, Alexander Viro wrote:

    Not really. Anything that modifies directories holds both ->i_sem and
    ->i_zombie, lookups hold ->i_sem and emptiness checks (i.e. victim in
    rmdir and overwriting rename) hold ->i_zombie, readdir holds both.

what performance issues does this raise in the cast of a directory
with _many_ files in it -- when we are renaming often involving that
directory?

I ask this because certain MTAs do just that; and when you have
10,000 to 100,000 messages queued I immagine you might spend much of
your time waiting for ->i_sem locks?

    Truncating is a piece of cake. Repacking is not a good idea,
    though, since you are risking massive corruption in case of dirty
    shutdown in the wrong moment.
    
ext2 directories seem somewhat susepctable to corruption on badly
timed shutdowns anyhow; and I don't think there is any way to do
atomic writes to them with most disk hardware is there?


  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
