Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbTDNSbd (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 14:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263723AbTDNS2f (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 14:28:35 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:6329 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263663AbTDNSO2 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 14:14:28 -0400
Date: Mon, 14 Apr 2003 19:25:53 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: top stack (l)users for 2.5.67
Message-ID: <20030414182544.GA6866@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030414173047.GJ10347@wohnheim.fh-wedel.de> <1050338275.25353.93.camel@dhcp22.swansea.linux.org.uk> <20030414174645.GK10347@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030414174645.GK10347@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 07:46:45PM +0200, J?rn Engel wrote:

 > +/* FIXME: should the below go into some header file? */
 > +#define PRESTO_COPY_KML_TAIL_BUFSIZE 4096
 >  struct file * presto_copy_kml_tail(struct presto_file_set *fset,
 >                                     unsigned long int start)
 >  {

so, presto_copy_kml_tail() is only called from
presto_finish_kml_truncate(), which doesn't seem to be called
from anywhere. What am I missing here? Or can this whole lot
just be nuked ?

If not, this patch introduces a problem.  You're now
calling a sleeping function (kmalloc) whilst holding
a lock according to the comment above presto_finish_kml_truncate()

		Dave

