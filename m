Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313927AbSDJX2D>; Wed, 10 Apr 2002 19:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313930AbSDJX2C>; Wed, 10 Apr 2002 19:28:02 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:13838 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S313927AbSDJX2C>;
	Wed, 10 Apr 2002 19:28:02 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7 and runaway modprobe loop? 
In-Reply-To: Your message of "Wed, 10 Apr 2002 11:00:49 MST."
             <Pine.LNX.4.33L2.0204101059130.25409-100000@dragon.pdx.osdl.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 11 Apr 2002 09:27:51 +1000
Message-ID: <9964.1018481271@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2002 11:00:49 -0700 (PDT), 
"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>| On Tue, 9 Apr 2002 09:17:08 -0700 (PDT),
>| "Randy.Dunlap" <rddunlap@osdl.org> wrote:
>| >If I build/boot 2.5.7 with 64 GB support (with or without
>| >high_pte), I get:
>| >
>| >Freeing unused kernel memory: 448k freed
>| >INIT: version 2.78 booting
>| >kmod: runaway modprobe loop assumed and stopped
>| >
>| >If I build/boot it with 4 GB support, it boots fine.
>
>I added module_name to the runaway message (OK ?) and its
>answer is binfmt-0000.
>
>I also moved from 2.5.7 to 2.5.8-pre2 and don't have this
>problem.

Interesting.  The binfmt-0000 implies that search_binary_handler() is
reading garbage for the executable.  It tries to load a handler for
binfmt-0000 which tries to execute modprobe which hits the same bug.
At a guess, the executable binary is not being mapped correctly with
64GB support.

