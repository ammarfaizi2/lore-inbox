Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318342AbSH1BFp>; Tue, 27 Aug 2002 21:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318368AbSH1BFo>; Tue, 27 Aug 2002 21:05:44 -0400
Received: from adsl-67-117-146-62.dsl.snfc21.pacbell.net ([67.117.146.62]:48133
	"EHLO localhost") by vger.kernel.org with ESMTP id <S318342AbSH1BFo>;
	Tue, 27 Aug 2002 21:05:44 -0400
From: "Stephen C. Biggs" <s.biggs@softier.com>
To: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Date: Tue, 27 Aug 2002 18:09:46 -0700
MIME-Version: 1.0
Subject: Re: Bug in kernel code?
Message-ID: <3D6BC06A.15764.57ED97@localhost>
In-reply-to: <20020827.174244.24647029.davem@redhat.com>
References: <3D6BB999.5183.3D4AB9@localhost>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Aug 2002 at 17:42, David S. Miller wrote:

>    From: "Stephen C. Biggs" <s.biggs@softier.com>
>    Date: Tue, 27 Aug 2002 17:40:41 -0700
>    
>    You're misunderstanding me, I meant that the  first test is done
>    AFTER the first iteration is   executed, so my fix is correct
>    since, even if order is 0 because at least one iteration of the
>    loop  is done, and the post decrement makes sure that the test
>    succeeds if order was 0 going into the loop.
> 
> Order is always >= 0 when we enter the loop.
> 
> If we actually get the table allocated then the decrement of 'order'
> is not executed if we allocate the table successfully.
> 
> I don't understand what the problem is with my fix.
> 
[Trying again - my mail client is messing up/sending empty posts]

As I look at it, it can only be 0 <= order < 32, so your fix works, as mine does.  Yours is simpler 
and doesn't involve changing code, just declarations.

There need to be some sanity checks in this code: what if mempages is passed as some insanely huge 
number, e.g.
