Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315921AbSFJTln>; Mon, 10 Jun 2002 15:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315923AbSFJTlm>; Mon, 10 Jun 2002 15:41:42 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:4882 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S315921AbSFJTlm>;
	Mon, 10 Jun 2002 15:41:42 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200206101940.g5AJeOk53653@saturn.cs.uml.edu>
Subject: Re: 2.5.21: fixdep starts spitting out 'unaligned traps'
To: kai@tp1.ruhr-uni-bochum.de (Kai Germaschewski)
Date: Mon, 10 Jun 2002 15:40:24 -0400 (EDT)
Cc: thunder7@xs4all.nl (Jurriaan on Alpha), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206100918380.20438-100000@chaos.physics.uiowa.edu> from "Kai Germaschewski" at Jun 10, 2002 09:25:04 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yeah, makes sense, that's a bug trap to test if we guessed endianness 
> right. Could you try to just comment out the call to traps() in main()?
> 
> The rest of the code should be safe. If commenting out fixes the problem, 
> could you try to replace
> 
> -	char *test = "CONF";
> +	static char __attribute__((aligned(8))) test[] = "CONF";

This works:

#include <netinet/in.h>

if(htonl(999UL)==999UL){
  // brain-dead byte order
}else{
  // correct byte order
}

