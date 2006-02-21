Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932749AbWBUQs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932749AbWBUQs6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 11:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932750AbWBUQs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 11:48:58 -0500
Received: from tomts10.bellnexxia.net ([209.226.175.54]:6863 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932749AbWBUQs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 11:48:58 -0500
Date: Tue, 21 Feb 2006 11:48:53 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Paul Mundt <lethal@linux-sh.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, axboe@suse.de,
       karim@opersys.com
Subject: Re: [PATCH, RFC] sysfs: relay channel buffers as sysfs attributes
Message-ID: <20060221164852.GA6489@Krystal>
References: <20060219171748.GA13068@linux-sh.org> <20060219175623.GA2674@kroah.com> <20060219185254.GA13391@linux-sh.org> <17401.21427.568297.830492@tut.ibm.com> <20060220130555.GA29405@Krystal> <20060220171531.GA9381@linux-sh.org> <20060220173732.GA7238@Krystal> <20060221152102.GA20835@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060221152102.GA20835@linux-sh.org>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.31-grsec (i686)
X-Uptime: 11:34:43 up 14 days, 12:49,  3 users,  load average: 0.38, 0.11, 0.03
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Paul Mundt (lethal@linux-sh.org) wrote:
> Wait a minute, you're talking about inode operations, but then talking
> about poll() and ioctl(), which are clearly file operations. Can you
> clarify what exactly it is you want to overload? Changing inode
> operations seems like a really bad design decision..
> 

You are right, I'm talking about file operations.

> Too much flexibility is not something people usually argue as a a point
> against adoption, especially for something as lightweight as debugfs,
> that's certainly a new one :-)
> 

Ok, I think we agree that it's not a technical matter. See below for
precisions.

> If you're talking about struct file_operations, then it would seem you
> would be best off sticking with debugfs. If the improved file operations
> are suitable for kernel/relay.c then they can be integrated there and
> then you don't have to worry about overloading the normal
> relay_file_operations through some helper functions to hand off to
> debugfs..
> 
> If you add native debugfs helper functions for creating relay files and
> working in line with CONFIG_RELAY, then I'm sure these can be rolled back
> in to debugfs proper, which should ease some of the LTTng maintenance.
> 
> I don't really see what having your own mount point and stubbed file
> system would buy you over this..
> 

As I understand the problem, LTTng could technically sit either in debugfs,
procfs, sysfs, relayfs : all these (except debugfs) have been tried with the
original LTT. I just want to spare time and not go into the same debates all
over again.

The problem sits in how tracing is seen. To kernel hackers, it is seen as an
interesting kernel debugging tool, while for the vast majority of LTTng
users, it is seen as a useful system wide information gathering tool to debug
_their_ system wide problems involving programs, librairies and drivers.

Therefore, I am reluctant to put a system monitoring tool in a filesystem
clearly indicated for kernel debugging, as the main audience for LTTng is
not kernel hackers, but user space application programmers.


Mathieu


OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
