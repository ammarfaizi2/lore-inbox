Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030373AbVLGVun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030373AbVLGVun (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 16:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbVLGVum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 16:50:42 -0500
Received: from web34106.mail.mud.yahoo.com ([66.163.178.104]:46689 "HELO
	web34106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030373AbVLGVul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 16:50:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=vutqvEzcdQnnbMXt9ixtKFLSoWmjUR1/GUynWzbHbjZbdSzBC7vKvHhN24Nu2afKma10PicB9QqvGhRu1vQjbYEDX77j0d6AUSiancd4Z2V9lHE9zP+KpyQjcqlsVJk6uWMDgmXBGBAwtcEJtkfCAqzhWuaU4Ugu9X9zZJGOjzY=  ;
Message-ID: <20051207215040.15310.qmail@web34106.mail.mud.yahoo.com>
Date: Wed, 7 Dec 2005 13:50:40 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: nfs question - ftruncate vs pwrite
To: Peter Staubach <staubach@redhat.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <439750A3.2030805@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Peter Staubach <staubach@redhat.com> wrote:
> You might use tcpdump or etherreal to see what the different traffic looks
> like.  I suspect that ftruncate() leads a SETATTR operation while pwrite()
> leads to a WRITE operation.

Ethereal results interpreted with wild speculation:
The pwrite case:
  This does a bunch of reads, but the server always returns a short read responding with EOF.  It
seems that a pwrite does cause a getattr call, but that's it.
  Once memory is exhausted, the pages are written out.

The ftruncate case:
  This does a setattr, then does a read - this time the server responds with a large amount of
0's.

Since this is using the buffer cache (not opened with O_DIRECT), and since we know we are
extending the file... is it strictly necessary to read in pages of 0's from the server?

-Kenny


		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 

