Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262352AbSJJWtk>; Thu, 10 Oct 2002 18:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262354AbSJJWtk>; Thu, 10 Oct 2002 18:49:40 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54024 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262352AbSJJWth>; Thu, 10 Oct 2002 18:49:37 -0400
Message-ID: <3DA60556.4020707@zytor.com>
Date: Thu, 10 Oct 2002 15:55:18 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Martin Waitz <tali@admingilde.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: weird semantics of cpu/*/msr
References: <20021010225221.GA1552@admingilde.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Waitz wrote:
> hi :)
> 
> the i386 msr driver is a bit strange:
> 
> * when reading/writing, it does not update the file position/msr register
> * file position is used directly as msr register
> 
> that is, reads with count>8 do read from the same register multiple
> times, and writes overwrite themselves.
> 
> i would expect the following semantics:
> * file position is (msr register * 8). position%8!=0 is invalid
> * read/write updating file position.
> 
> that would make it possible to write/read multiple MSRs with one
> syscall, which is very handy when initializing P4 performance counters.
> 
> should i implement that behaviour?
> of course it would break binary compatibility with existing
> uses of that drivers.
> perhaps we would need a new location for the new api.
> 

No, you should not.

Simply put, the semantics were chosen for what typically makes sense
w.r.t. MSRs.

	-hpa


