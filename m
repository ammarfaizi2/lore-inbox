Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265390AbRF0ToB>; Wed, 27 Jun 2001 15:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265396AbRF0Tnv>; Wed, 27 Jun 2001 15:43:51 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:8455 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S265390AbRF0Tne>; Wed, 27 Jun 2001 15:43:34 -0400
Date: Wed, 27 Jun 2001 16:43:28 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Chris Mason <mason@suse.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Xuan Baldauf <xuan--lkml@baldauf.org>, <linux-kernel@vger.kernel.org>,
        <andrea@suse.de>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: VM deadlock
In-Reply-To: <910160000.993670608@tiny>
Message-ID: <Pine.LNX.4.33L.0106271641570.23373-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jun 2001, Chris Mason wrote:

> Reiserfs expects write_inode() calls initiated by kswapd to
> always have sync==0.  Otherwise, kswapd ends up waiting on the
> log, which isn't what we want at all.

If you don't have free memory, you are limited to 2 choices:

1) wait on IO
2) spin endlessly, wasting CPU until the IO is done

If (1) isn't possible in reiserfs, I'd say something in
reiserfs needs to be fixed, otherwise you will always
have problems when the system has lots of dirty mappings
that need to be written out.

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

