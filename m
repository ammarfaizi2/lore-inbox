Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbTDOMVq (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 08:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbTDOMVq 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 08:21:46 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:25790
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261317AbTDOMVp convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 08:21:45 -0400
Subject: Re: Writing modules for 2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <yw1xllyc7yoz.fsf@zaphod.guide>
References: <yw1x7k9w9flm.fsf@zaphod.guide.suse.lists.linux.kernel>
	 <p73adesxane.fsf@oldwotan.suse.de>  <yw1xllyc7yoz.fsf@zaphod.guide>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1050406513.27745.32.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Apr 2003 12:35:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-04-15 at 13:05, Måns Rullgård wrote:
> Next question:  what is the correct replacement for MOD_INC_USE_COUNT?

If you know the use count is already one there isnt one, jut use
MOD_INC_USE_COUNT and flame Rusty

If you can't prove the use count is already one for your own module
you have a problem (and did in 2.4 in truth). The layers try and 
lock the layer below. So char drivers are locked by core code,
block drivers likewise, tty drivers and so on...

Most driver layers now have an owner: field in the file ops or other
structure they register

	owner: THIS_MODULE,

(THIS_MODULE comes out currently in a non modular buils too)

