Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266737AbSKOUfb>; Fri, 15 Nov 2002 15:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266746AbSKOUfb>; Fri, 15 Nov 2002 15:35:31 -0500
Received: from holomorphy.com ([66.224.33.161]:18129 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266737AbSKOUfa>;
	Fri, 15 Nov 2002 15:35:30 -0500
Date: Fri, 15 Nov 2002 12:38:54 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Kallol Biswas <kallol.biswas@efi.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: lan based kgdb
Message-ID: <20021115203854.GB23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Kallol Biswas <kallol.biswas@efi.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3DD5591E.A3D0506D@efi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD5591E.A3D0506D@efi.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2002 at 12:29:18PM -0800, Kallol Biswas wrote:
> Is there a source level remote kernel debugger that
> communicates over an ethernet interface? The debugger
> kgdb from kgdb.sourceforge.net works only with serial port.

With some hacking to produce a polling network driver, it should very
well be possible to provide a communication back-end for a gdb stub
that uses an ethernet NIC.

gdb itself is already perfectly capable of communicating with
such targets, using the specifier

	target remote otherhost:1234

where 1234 is the port number the gdb stub on the target reserves for
itself to communicate with the host. It's probably best to use a
dedicated network interface, though it's not absolutely required. (With
a dedicated interface otherhost will then be the interface's hostname.)

A serious issue is that the communication protocol is somewhat more
complex, so there is a possibility the debug runtime will not be robust.

Bill
