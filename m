Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbTKLEbg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 23:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbTKLEbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 23:31:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22985 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261555AbTKLEbf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 23:31:35 -0500
Date: Wed, 12 Nov 2003 04:31:34 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Daniel Craig <dancraig@internode.on.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-bk16 ALi M5229 kernel boot error
Message-ID: <20031112043133.GD24159@parcelfarce.linux.theplanet.co.uk>
References: <1201.192.168.0.5.1068605203.squirrel@stingray.homelinux.org> <Pine.LNX.4.44.0311111901490.1694-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311111901490.1694-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 11, 2003 at 07:04:17PM -0800, Linus Torvalds wrote:
 
> Yes. The ALI driver has some really strange code to avoid tweaking non-ALI 
> southbridges. 
> 
> But the thing is, it breaks even _with_ ALI southbridges, if we just don't 
> find the ALI bridge we expect.
> 
> Does this patch fix it?
> -	if (north && north->vendor != PCI_VENDOR_ID_AL) {
> +	if (!isa_dev) {

Wrong fix, AFAICS.  Original condition is bogus, no arguments here.
However, the point is
	"tweak our southbridge only if northbridge is known to be OK with that"
and not
	"tweak southbridge only if it's ours"

IOW, proper check is || of those two.
