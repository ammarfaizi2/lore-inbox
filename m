Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTLCXgL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 18:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbTLCXgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 18:36:11 -0500
Received: from bolt.sonic.net ([208.201.242.18]:27367 "EHLO bolt.sonic.net")
	by vger.kernel.org with ESMTP id S262714AbTLCXgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 18:36:02 -0500
Date: Wed, 3 Dec 2003 15:36:01 -0800
From: David Hinds <dhinds@sonic.net>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>, linux-kernel@vger.kernel.org
Subject: Re: Worst recursion in the kernel
Message-ID: <20031203153601.A23640@sonic.net>
References: <20031203143122.GA6470@wohnheim.fh-wedel.de> <20031203100709.B6625@sonic.net> <20031203190440.GA15857@wohnheim.fh-wedel.de> <20031203225743.A25889@flint.arm.linux.org.uk> <20031203230832.GD29119@mis-mike-wstn.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031203230832.GD29119@mis-mike-wstn.matchmail.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 03:08:32PM -0800, Mike Fedyk wrote:
> On Wed, Dec 03, 2003 at 10:57:43PM +0000, Russell King wrote:
> > Yes, but the condition of the /data/ is such that it will not recurse.
> > 
> > A pure "can this function call that function" analysis ignoring the
> > state of the data will say this will infinitely recuse.  Include
> > the data, and you'll find it has a very definite recursion limit.
> 
> Is the data verified?

Russell is using "data" loosely.  Basically the logic goes like this:

read_cis_mem():
  if sys_start is NULL then call validate_mem()

validate_mem():
  set sys_start
  call stuff that calls read_cis_mem()

so the functions do not require consistency of any external program
data to avoid recursion.

-- Dave

