Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262090AbVC1Wih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbVC1Wih (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 17:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbVC1Wih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 17:38:37 -0500
Received: from gate.crashing.org ([63.228.1.57]:62674 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262090AbVC1Wif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 17:38:35 -0500
Subject: Re: [PATCH] radeonfb: Fix mode setting on CRT monitors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <4247F2AA.7070201@ens-lyon.org>
References: <1111969496.5409.40.camel@gaston>
	 <4247F2AA.7070201@ens-lyon.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 29 Mar 2005 08:37:47 +1000
Message-Id: <1112049467.5409.76.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-28 at 14:03 +0200, Brice Goglin wrote:
> Benjamin Herrenschmidt a écrit :
> > Hi !
> > 
> > Current radeonfb is a bit "anal" about accepting CRT modes, it basically only
> > accepts modes that have the exact resolution, which tends to break with fbcon
> > on console switches as it provides "approximate" modes. This patch fixes it
> > by having the driver chose the closest possible mode instead of looking for
> > an exact match.
> 
> Hi Benjamin,
> 
> I tried your patch because on recent -mm kernels I see dirty colored 
> columns during a few seconds when switching from X to radeon fbcon
> (looks like remaining colors of X).
> I don't know what visible effect your patch is supposed to have.
> I didn't see any difference, but I doesn't seem to break anything.

The effect is that if your console resolution isn't an exact multiple of
the character width or height, radeonfb would fail to set the mode on
console switches. It doesn't happen with 1024x768 and default font but
it does happen with some weird modes, and some monitors (/me lurks
toward IBM) tend to have quite broken default EDID timings.

Ben.
 

