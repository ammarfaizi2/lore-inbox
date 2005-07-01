Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263268AbVGAHsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263268AbVGAHsH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 03:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbVGAHsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 03:48:07 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:4881 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S263268AbVGAHry
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 03:47:54 -0400
Message-ID: <42C4F52B.4080508@slaphack.com>
Date: Fri, 01 Jul 2005 02:47:55 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hubert Chan <hubert@uhoreg.ca>
Cc: Hans Reiser <reiser@namesys.com>, Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <hubert@uhoreg.ca>	<200506290509.j5T595I6010576@laptop11.inf.utfsm.cl>	<87hdfgvqvl.fsf@evinrude.uhoreg.ca>	<8783be6605062914341bcff7cb@mail.gmail.com>	<42C3615A.9020600@namesys.com> <871x6kv4zd.fsf@evinrude.uhoreg.ca>	<20050630062956.GP16867@khan.acc.umu.se> <87psu3vnvc.fsf@evinrude.uhoreg.ca>
In-Reply-To: <87psu3vnvc.fsf@evinrude.uhoreg.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert Chan wrote:
> On Thu, 30 Jun 2005 08:29:56 +0200, David Weinehall <tao@acc.umu.se> said:
> 
> 
>>On Thu, Jun 30, 2005 at 12:33:10AM -0400, Hubert Chan wrote:
>>
>>>It's sort of like the way web servers handle index.html, for those
>>>who think it's a stupid idea.  (Of course, some people may still
>>>think it's a stupid idea... ;-) )
> 
> 
>>And guess what?  That's handled on the web server level (userland),
>>not by the file system.  So different web servers can handle it
>>differently (think index.html.sv, index.html.zh, index.php, etc).
> 
> 
> From the web *browser*'s point of view, it is handled by the
> "filesystem" (which is provided by the various servers).  The browser
> doesn't care how or where the data is stored.  It just requests a file,
> and gets some data back.  So the browser doesn't have to check for
> http://www.example.com/, get a failure (trying to read a directory),
> check for http://www.example.com/index.html, etc.  In this way, the web
> server controls (which I think takes the place of the filesystem in this
> case) what gets shown (index.html.sv, etc.), instead of the leaving it
> up to the browser.

Somewhat flawed analogy, though.  After the protocol definition, the 
browser proper will take any URL that the protocol handler likes, which 
is why file:// works.  After the domain, the http/https handler will 
take any URL at all, except for maybe some character set issues.  So 
assuming the server is compatible with itself, we don't have to worry 
about whether the browser supports going to a directory and having it 
behave as a file (index.html behavior), or going to a file and having it 
behave as a directory (as some scripts do -- I've seen urls that look 
like http://example.com/foo.cgi/bar.html)

Among protocols that behave more like filesystems, such as FTP, you 
can't really pull the same tricks.  When an FTP client asks for a 
directory, it's probably asking for a directory listing, and would be 
quite surprised to find a file there -- or the user would when binary 
data floods their terminal.

I *think* this is how FTP works, but I haven't used it in years, except 
through a web browser.  I still get the feeling that even a web browser 
expects an FTP file to behave as a file and an FTP directory to behave 
as a directory.

But I'm also pretty sure that FTP would be much more receptive to 
file-as-directory than your average sysadmin would.  For one, breaking 
tar is unforgivable, and the only ways I can think of fixing that issue 
are shaky at best when you consider how many apps might do things 
oh-so-slightly different than tar.

