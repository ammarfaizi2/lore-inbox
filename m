Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261592AbSIXJQE>; Tue, 24 Sep 2002 05:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261603AbSIXJQE>; Tue, 24 Sep 2002 05:16:04 -0400
Received: from angband.namesys.com ([212.16.7.85]:27272 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S261592AbSIXJQD>; Tue, 24 Sep 2002 05:16:03 -0400
Date: Tue, 24 Sep 2002 13:21:10 +0400
From: Oleg Drokin <green@namesys.com>
To: Jakob Oestergaard <jakob@unthought.net>, linux-kernel@vger.kernel.org,
       Hans Reiser <reiser@namesys.com>
Subject: Re: ReiserFS buglet
Message-ID: <20020924132110.A22362@namesys.com>
References: <20020924072455.GE2442@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020924072455.GE2442@unthought.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Sep 24, 2002 at 09:24:55AM +0200, Jakob Oestergaard wrote:

> In linux-2.4.19, I found the following:
> fs/reiserfs/super.c:707
>  s->s_blocksize = sb_blocksize(rs);
>  s->s_blocksize_bits = 0;
>  while ((1 << s->s_blocksize_bits) != s->s_blocksize)
>      s->s_blocksize_bits ++;
> What happens if there's a bit-flip on the disk so that s->s_blocksize is
> not a power of two ?

FS will refuse to mount. Or kernel will panic (depends on some stuff).
If s->s_blocksize is zeroed, kernel will hang, as you correctly noticed.

> I would suggest replacing the '!=' with a '<' in the while loop and
> adding a sanity check afterwards.

What if overheated CPU will cause a bitflip exactly after such checks?
You cannot protect against broken hardware. Such problems should be
fixed by fsck.

> As I see it, the ReiserFS journal has the same problems as jbd wrt. to
> atomicity of write operations of indexes.  Please see my recent mail
> about the jbd problems.

journal header in reiserfs only occupies first 20 bytes of the block,
since this fells within 1st 512 bytes hardware sector, it will be written
atomically, I presume.

Bye,
    Oleg
