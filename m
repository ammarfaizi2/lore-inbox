Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbVAYVfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbVAYVfw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 16:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVAYVeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 16:34:18 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:29200 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262166AbVAYVbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 16:31:49 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH 6/12] random pt4: Replace SHA with faster version
Date: Tue, 25 Jan 2005 23:31:19 +0200
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, "Theodore Ts'o" <tytso@mit.edu>,
       linux-kernel@vger.kernel.org
References: <7.314297600@selenic.com> <200501252307.21993.vda@port.imtp.ilyichevsk.odessa.ua> <20050125211401.GO12076@waste.org>
In-Reply-To: <20050125211401.GO12076@waste.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501252331.19527.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 January 2005 23:14, Matt Mackall wrote:
> On Tue, Jan 25, 2005 at 11:07:21PM +0200, Denis Vlasenko wrote:
> > On Friday 21 January 2005 23:41, Matt Mackall wrote:
> > > - * @W:      80 words of workspace
> > > + * @W:      80 words of workspace, caller should clear
> > 
> > Why?
> 
> Are you asking why should the caller clear or why should it be cleared at all?
> 
> For the first question, having the caller do the clear avoids
> redundant clears on repeated calls.
> 
> For the second question, forward security. If an attacker breaks into
> the box shortly after a secret is generated, he may be able to recover
> the secret from such state.

Whoops. I understood a comment as 'caller should clear prior to use'
and this seems to be untrue (code overwrites entire W[80] vector
without using prior contents).

Now I think that you most probably meant 'caller should clear AFTER use'.
If so, comment should be amended.
--
vda

