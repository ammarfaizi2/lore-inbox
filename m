Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285085AbRLLH2V>; Wed, 12 Dec 2001 02:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285087AbRLLH2M>; Wed, 12 Dec 2001 02:28:12 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:32699
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S285085AbRLLH2F>; Wed, 12 Dec 2001 02:28:05 -0500
Date: Wed, 12 Dec 2001 02:17:09 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: jaharkes@cs.cmu.edu
Cc: Cameron Simpson <cs@zip.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@caldera.de>,
        Keith Owens <kaos@ocs.com.au>, kbuild-devel@lists.sourceforge.net,
        torvalds@transmeta.com
Subject: Re: CML2 with python1
Message-ID: <20011212021709.A8076@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>, jaharkes@cs.cmu.edu,
	Cameron Simpson <cs@zip.com.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@caldera.de>, Keith Owens <kaos@ocs.com.au>,
	kbuild-devel@lists.sourceforge.net, torvalds@transmeta.com
In-Reply-To: <20011204120305.A16578@thyrsus.com> <E16BJcB-0002o7-00@the-village.bc.nu> <20011205125938.A21170@zapff.research.canon.com.au> <20011205032954.B4836@thyrsus.com> <20011205051734.A22345@cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011205051734.A22345@cs.cmu.edu>; from jaharkes@cs.cmu.edu on Wed, Dec 05, 2001 at 05:17:34AM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Harkes <jaharkes@cs.cmu.edu>:
> But it _is_ entirely practical to run CML2 with a bog-standard python
> 1.5 interpreter. I just did a search/replace for the python2-ism's like
> 
>  <x> += <y>           =>  <x> = <x> + <y>, and
>  <string>.<op>(<arg>) => string.<op>(<string>, <arg>)
> 
> Worked around some missing functionality in the older shlex and curses
> modules and I can now use oldconfig, menuconfig, xconfig, and cmladvent
> with CML2 and a python1 interpreter. It also still works fine with
> python2 as well.
> 
> 	http://ravel.coda.cs.cmu.edu/cml2-1.9.4-python1.patch (36K)
> 
> 36K might sound like a lot, but given the fact that the CML python
> sources totals about 280KB, it is a pretty small diff, and the whole
> "but python2 isn't standard in distributions and the license is bad"
> argument can be dropped and we can get on with life.

It's a good try.  But there are some important things missing from
this patch -- notably the Textpad class, which is needed for doing
popup queries correctly.  

Also, arrow keys don't work under the curses implementation linked
with in Red Hat's python1.5.  This is a symptom of a deeper problem,
which is that older Pythons link the Berkeley curses library rather
than ncurses.

Clicking on a URL link with bomb xconfig with this patch under 1.5.  You
didn't handle `import webbrowser' failure.  Easy thing to miss.

I personally added the ncurses/Textpad/ascii features to the Python
libraries shipped in 2.0, and I did it for a reason -- to support what
`make menuconfig' needs.  Backporting to 1.5.2 is only going to give a
partial, ugly subset of menuconfig.  I don't think it's good enough.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"This country, with its institutions, belongs to the people who inhabit it. 
Whenever they shall grow weary of the existing government, they can exercise
their constitutional right of amending it or their revolutionary right to 
dismember it or overthrow it."	-- Abraham Lincoln, 4 April 1861
