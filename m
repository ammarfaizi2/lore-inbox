Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266833AbUHISvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266833AbUHISvL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266870AbUHISuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:50:54 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:55607 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S266867AbUHISrC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:47:02 -0400
Date: Mon, 9 Aug 2004 20:48:59 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] Host Virtual Serial Interface driver
Message-ID: <20040809184859.GA20397@mars.ravnborg.org>
Mail-Followup-To: Hollis Blanchard <hollisb@us.ibm.com>,
	linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
References: <1091827384.31867.21.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091827384.31867.21.camel@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 04:23:05PM -0500, Hollis Blanchard wrote:

Small comments after a _very_ quick skim.

	Sam

> static struct tty_struct *hvsi_recv_control(struct hvsi_struct *hp,
> 		uint8_t *packet)
> {
> 	struct tty_struct *to_hangup = NULL;
> 	struct hvsi_control *header = (struct hvsi_control *)packet;
> 
> 	switch (header->verb) {
> 		case VSV_MODEM_CTL_UPDATE:
> 			if ((header->word & HVSI_TSCD) == 0) {
> 				/* CD went away; no more connection */
> 				pr_debug("hvsi%i: CD dropped\n", hp->index);
> 				hp->mctrl &= TIOCM_CD;
> 				if (!(hp->tty->flags & CLOCAL))
> 					to_hangup = hp->tty;
> 			}
> 			break;
> 		case VSV_CLOSE_PROTOCOL:
> #warning here

This "#warning" should be deleted..

> 
> #ifdef DEBUG
> 	pr_debug("%s: sending %i bytes\n", __FUNCTION__, packet.len);
> 	dump_hex((uint8_t*)&packet, packet.len);
> #endif

pr_debug is a noop if DEBUG is not defined. Make dump_hex, dump_packet
be a noop also and you get rid of several #ifdef in the code.


