Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130166AbQKFRt4>; Mon, 6 Nov 2000 12:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130165AbQKFRtq>; Mon, 6 Nov 2000 12:49:46 -0500
Received: from puce.csi.cam.ac.uk ([131.111.8.40]:151 "EHLO puce.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S129816AbQKFRtl>;
	Mon, 6 Nov 2000 12:49:41 -0500
From: "James A. Sutherland" <jas88@cam.ac.uk>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
Date: Mon, 6 Nov 2000 17:45:17 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
In-Reply-To: <00110617033201.01646@dax.joh.cam.ac.uk> <200011061657.eA6Gv0w08964@pincoya.inf.utfsm.cl> <7101.973530736@redhat.com>
In-Reply-To: <7101.973530736@redhat.com>
MIME-Version: 1.0
Message-Id: <00110617484703.24534@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2000, David Woodhouse wrote:
> jas88@cam.ac.uk said:
> >  So set them on startup. NOT when the driver is first loaded. Put it
> > in the rc.d scripts. 
> 
> No. You should initialise the hardware completely when the driver is 
> reloaded. Although the expected case is that the levels just happen to be 
> the same as the last time the module was loaded, you can't know that the 
> machine hasn't been suspended and resumed since then.

If suspend/resume changes the settings of the card, you need to deal with that
as a separate issue - otherwise resume isn't restoring things properly. Perhaps
you need to prevent module unloading. Just restoring the correct settings when
the driver is loaded is definitely too late.

> jas88@cam.ac.uk said:
> >  No need. Let userspace save it somewhere, if that's needed. 
> 
> Don't troll, James. Reread the thread and see why doing it in userspace is 
> too late.

Why is it too late? There is no need for the driver to set *any* volume levels
on load. When told to load the driver, just LOAD the DRIVER. Don't reset the
card, or make ANY changes.


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
