Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWFTPX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWFTPX4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 11:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWFTPXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 11:23:55 -0400
Received: from gw.openss7.com ([142.179.199.224]:17312 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S1751318AbWFTPXz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 11:23:55 -0400
Date: Tue, 20 Jun 2006 09:23:51 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Theodore Tso <tytso@mit.edu>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 2/8] inode-diet: Move i_pipe into a union
Message-ID: <20060620092351.E10897@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	linux-kernel@vger.kernel.org
References: <20060619152003.830437000@candygram.thunk.org> <20060619153108.720582000@candygram.thunk.org> <Pine.LNX.4.61.0606191918310.23792@yvahk01.tjqt.qr> <20060619190610.GH15216@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060619190610.GH15216@thunk.org>; from tytso@mit.edu on Mon, Jun 19, 2006 at 03:06:10PM -0400
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore,

On Mon, 19 Jun 2006, Theodore Tso wrote:
> 
> As was mentioned in earlier comment, this will be problematic for the
> out-of-tree System V Streams code, which hijacks i_pipe as another
> place to store 4 bytes of random data needed for the Streams code (I
> believe they needed a pointer to the stream head -- the v_str pointer
> in a legacy Unix system's inode).  But, that is an out-of-tree kernel
> module, and it's a clear abuse of the i_pipe element in any case.

It's used for implementing STREAMS-based FIFOs.  Which is a proper use
of i_pipe (which is for FIFOs).  Pipes (both mainline and STREAMS-based
pipes) can use i_private instead of i_pipe.

For the same reason why i_pipe cannot be combined with i_private.

