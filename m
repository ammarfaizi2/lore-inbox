Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265250AbSKYTGr>; Mon, 25 Nov 2002 14:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265275AbSKYTGr>; Mon, 25 Nov 2002 14:06:47 -0500
Received: from almesberger.net ([63.105.73.239]:25352 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265250AbSKYTGq>; Mon, 25 Nov 2002 14:06:46 -0500
Date: Mon, 25 Nov 2002 16:13:52 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Patrick Mochel <mochel@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] sysfs on 2.5.48 unable to remove files while in use
Message-ID: <20021125161352.D1549@almesberger.net>
References: <20021124113258.S17062@almesberger.net> <Pine.LNX.4.33.0211251136590.898-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0211251136590.898-100000@localhost.localdomain>; from mochel@osdl.org on Mon, Nov 25, 2002 at 12:34:54PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
> The difference is that sysfs directories are tied to kobjects. By writing
> to the file with the specific syntax, you are telling the module to create
> an object with the parameters you give. Once the object is registered, a 
> directory is created for it, and it's only removed when the object is 
> unregistered. We don't just randomly create directories. 

Yes, and I think that's perfect. All I'm suggesting is to use
mkdir/rmdir to make the creation/removal request, and then use
whatever is convenient for ensuring that things stay unique (i.e.
resolve it either at the VFS, kprobes, or "glue" level).

I fully agree that creating interrelated objects at two distinct
places in the kernel and then trying to "synchronize" them leads
to madness. (*)

(*) Actually, someone in academia who works with protocol
    validations, and has a bit too much time on his or her hands,
    should once try to find an elegant way of linking this type of
    in-kernel dependencies to a validation tool like Spin.

    Right now, the process for validating such a mess is still to
    abstract the design into a model in a language like Promela
    (very slick, but decidedly "alien"), SyncC++ (C-ish, but still
    too far from real kernel code), etc., and to validate the
    model.

    I've done this on some occasions (and discovered interesting
    bugs in the process), but the pain threshold required is a bit
    too high to suggest this as a general procedure.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
