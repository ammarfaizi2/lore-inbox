Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269691AbRHIGVC>; Thu, 9 Aug 2001 02:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269692AbRHIGUx>; Thu, 9 Aug 2001 02:20:53 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:7432 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S269687AbRHIGUq>;
	Thu, 9 Aug 2001 02:20:46 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200108090620.f796KdG309141@saturn.cs.uml.edu>
Subject: Re: [RFC][PATCH] parser for mount options
To: viro@math.psu.edu (Alexander Viro)
Date: Thu, 9 Aug 2001 02:20:39 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0108071227080.18565-100000@weyl.math.psu.edu> from "Alexander Viro" at Aug 07, 2001 01:02:05 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:

> What I wanted to get:
> 	* set of options accepted by fs and syntax of their arguments
> should be visible in source. Explicitly.
> 	* no cascades of strcmp/strncmp/peeking at individual characters
> by hands.

Yay! You still have the switch() though, and ugly enums.
Since the kernel is tied to gcc anyway, one might as well...

int foofs_parser(/* ... */){
     static match_table_t tokens = {
          {&&Opt_uid, "uid=%u"},
          {&&Opt_gid, "gid=%u"},
          {&&Opt_ownmask, "ownmask=%o"},
          {&&Opt_othmask, "othmask=%o"},
          {&&Opt_err, NULL}
     };
     /* ... */
     while(( p=whatever() ){
          goto *(match_token(p, tokens, args));  /* gcc's computed goto */

          Opt_uid:
               /* code for uid */
               continue;
          Opt_gid:
               /* code for gid */
               continue;
          Opt_ownmask:
               /* code for ownmask */
               continue;
          Opt_othmask:
               /* code for othmask */
               continue;
          Opt_err:
               /* error code */
     }
}
