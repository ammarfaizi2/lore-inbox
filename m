Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318795AbSHLTWT>; Mon, 12 Aug 2002 15:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318797AbSHLTWT>; Mon, 12 Aug 2002 15:22:19 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:13 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S318795AbSHLTWS>; Mon, 12 Aug 2002 15:22:18 -0400
Date: Mon, 12 Aug 2002 15:36:06 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Hans Reiser <reiser@namesys.com>
Cc: Andrew Morton <akpm@zip.com.au>,
       Hans Reiser <reiser@bitshadow.namesys.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BK] [PATCH] reiserfs changeset 7 of 7 to include into 2.4 tree
In-Reply-To: <3D555823.7040204@namesys.com>
Message-ID: <Pine.LNX.4.44.0208121533470.3048-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 Aug 2002, Hans Reiser wrote:

> I forgot to mention that a variety of benchmarks of various allocator
> options are on www.namesys.com/benchmarks.html.  They aren't very
> understandable, but if questions are asked I'll answer them.

I get this from the "Mongo" benchmark homepage.

I suppose the behaviour with your patches is "skip_busy", right?


Block allocator options are passed with alloc=opt1:opt2:... mount
parameter, where opt1, opt2,... are:

      skip_busy:
            Try to allocate blocks in block-groups (called bitmaps in
reiserfs) that have more than 10% of blocks free first, if that fail,
allocate anywhere.
      concentrating_formatted_nodes=X:
            turned on 'border algorithm' and put this border in X% of
available space.
      old_way:
            Mimic original block allocator from 2.4.18
      displacing_new_packing_localities:
            Displace formatted nodes of directories at creation time.
Displacing is the hash from the dir_id.
      displacing_large_files:
            Takes one parameter - a blocknumber. When this blocknumber
allocated for the file, it is placed separately on disk (by default new
location is the keyed_hash from the object_id
            value. "displace_based_on_dirid" will change that.
      displace_based_on_dirid:
            When displacing files, place files that live in same directory
in the same disk area. (achieved by hashing by dir_id value of ondisk_key,
instead of object_id)

----

