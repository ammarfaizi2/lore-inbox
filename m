Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266901AbUHITOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266901AbUHITOJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 15:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266917AbUHITNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 15:13:36 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:39067 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266912AbUHITMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 15:12:49 -0400
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC] Host Virtual Serial Interface driver
Date: Mon, 9 Aug 2004 14:08:04 -0500
User-Agent: KMail/1.5.4
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
References: <1091827384.31867.21.camel@localhost> <200408091351.49211.hollisb@us.ibm.com> <20040809190042.GB20397@mars.ravnborg.org>
In-Reply-To: <20040809190042.GB20397@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408091408.04745.hollisb@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 August 2004 14:00, Sam Ravnborg wrote:
> On Mon, Aug 09, 2004 at 01:51:49PM -0500, Hollis Blanchard wrote:
> > > pr_debug is a noop if DEBUG is not defined. Make dump_hex, dump_packet
> > > be a noop also and you get rid of several #ifdef in the code.
> >
> > I'd like to do that, but notice that dump_hex() is called from
> > dump_packet() from hvsi_recv_response() (and I've just made
> > hvsi_recv_control() the same). Even with debug disabled, I'd like to be
> > able to dump a whole packet if I get confused...
>
> Make a small wrapper that becomes noop in non-debug case,
> and use the real one where you do not care about DEBUG.

Ah sure, like this:

#ifdef DEBUG
#define dbg_dump_packet(packet) dump_packet(packet)
#define dbg_dump_hex(data, len) dump_hex(data, len)
#else
#define dbg_dump_packet(packet)
#define dbg_dump_hex(data, len)
#endif

... and then replace the in-DEBUG callers. I like it, thanks.

-- 
Hollis Blanchard
IBM Linux Technology Center
