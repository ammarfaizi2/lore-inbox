Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136033AbRAHSTi>; Mon, 8 Jan 2001 13:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136558AbRAHST1>; Mon, 8 Jan 2001 13:19:27 -0500
Received: from c-025.static.AT.KPNQwest.net ([193.154.188.25]:58870 "EHLO
	stefan.sime.com") by vger.kernel.org with ESMTP id <S136033AbRAHSTT>;
	Mon, 8 Jan 2001 13:19:19 -0500
Date: Mon, 8 Jan 2001 19:18:33 +0100
From: Stefan Traby <stefan@hello-penguin.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Stefan Traby <stefan@hello-penguin.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
Message-ID: <20010108191833.A1764@stefan.sime.com>
Reply-To: Stefan Traby <stefan@hello-penguin.com>
In-Reply-To: <20010108172225.A1391@stefan.sime.com> <Pine.GSO.4.21.0101081304380.4061-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0101081304380.4061-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Mon, Jan 08, 2001 at 01:05:49PM -0500
Organization: Stefan Traby Services && Consulting
X-Operating-System: Linux 2.4.0-fijiji0 (i686)
X-APM: 100% 400 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 01:05:49PM -0500, Alexander Viro wrote:
> 
> 
> On Mon, 8 Jan 2001, Stefan Traby wrote:
> 
> > On Mon, Jan 08, 2001 at 04:01:10PM +0000, Alan Cox wrote:
> > > > I prefer SuS fpathconf(), pathconf() is just a wrapper to fpathconf();
> > > 
> > > You can't implement it that way in the corner cases.
> > 
> > I reread SuSv2 again and didn't found corner cases.
> > Do you mean FIFO/pipe stuff ? I can't see the problem in this area.
> > 
> > In which case is an emulation of pathconf by fpathconf impossible ?
> 
> Damnit, symlinks for one thing.

No this is no problem.

 For pathconf(), the path argument points to the pathname of a file
      or directory.

IMHO lstat can dedect this case.
Where is the problem ?
Calling pathconf with a symlink is not defined. I suggest
an implementation of "yankee doodle" for that case.
Anyway the broken SuS standard wants that pathconf follow symlinks.
Or how do you interpret this:

 [ELOOP]
           Too many symbolic links were encountered in resolving path.

But Alan's case "out of filedescriptor" fully counts.
Anyway, I personally would ignore it, but I agree, it's a completely
valid argument.

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
