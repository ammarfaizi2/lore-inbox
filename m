Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132434AbQK0Cgd>; Sun, 26 Nov 2000 21:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S135321AbQK0CgY>; Sun, 26 Nov 2000 21:36:24 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:15623 "EHLO
        pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
        id <S132434AbQK0CgM>; Sun, 26 Nov 2000 21:36:12 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: initdata for modules? 
In-Reply-To: Your message of "Sun, 26 Nov 2000 19:49:43 PDT."
             <20001126194943.F2265@vger.timpanogas.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 27 Nov 2000 13:06:04 +1100
Message-ID: <3478.975290764@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2000 19:49:43 -0700, 
"Jeff V. Merkey" <jmerkey@vger.timpanogas.org> wrote:
>Microsoft drivers have an .INIT code section that is initialization 
>ccode that get's chunked after it's loaded.  Their model allows 
>memory segments to be defined as DISCARDABLE, which tells the loader
>to chunk them after they get loaded in portable executable format.  

The loader is insmod, which does all its own reloaction and loading.
The problem is that ancillary tools like ksymoops, gdb, kdb and
possibly others do not expect sections to be discarded after load.
Adding the feature to insmod is fairly easy, fixing the ancillary tools
to understand that some sections are discarded after load is a bit
harder.  Debugging is particularly messy, when an oops occurs how do we
tell if the __init data been discarded yet or not?

I have added this to my investigation list for modutils, ksymoops and
kdb 2.5, no promises.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
