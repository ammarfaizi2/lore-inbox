Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316695AbSEVTdi>; Wed, 22 May 2002 15:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316699AbSEVTdh>; Wed, 22 May 2002 15:33:37 -0400
Received: from imladris.infradead.org ([194.205.184.45]:57618 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316695AbSEVTdg>; Wed, 22 May 2002 15:33:36 -0400
Date: Wed, 22 May 2002 20:33:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dan Kegel <dank@kegel.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "khttpd-users@lists.alt.org" <khttpd-users@alt.org>,
        "linuxppc-embedded@lists.linuxppc.org" 
	<linuxppc-embedded@lists.linuxppc.org>,
        lord@sgi.com
Subject: Re: khttpd and tmpfs don't get along?
Message-ID: <20020522203328.A22461@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dan Kegel <dank@kegel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"khttpd-users@lists.alt.org" <khttpd-users@lists.alt.org>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>,
	lord@sgi.com
In-Reply-To: <3CEAF6F2.BB70395D@kegel.com> <20020522095440.A13744@infradead.org> <3CEBEF97.1BEBF36C@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 12:20:55PM -0700, Dan Kegel wrote:
> I just now crashed Red Hat 7.3 on x86 SMP by compiling in khttpd
> and serving files out of a tmpfs.  It crashed with or without my 
> earlier patch (http://www.kegel.com/linux/khttpd/khttpd-unbork.patch)
> that fixes khttpd crashes with other filesystems.
> Guess it wasn't a bug in linuxppc_2_4_devel after all.

I doubt it. the use of do_generic_file_read outside of code the filesystem
has selected to use (i.e. generic methods) is FUNDAMENTALLY broken.

Some time ago I though I found a similar bug in XFS, but Steve Lord says
it's not exploitable in real world (XFS uses the generic methods with
additional locking around it).

The only sane soloution is to get rid of that abuse in khttpd, loop and
sys_sendfile.

