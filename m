Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <971192-9428>; Fri, 24 Apr 1998 06:23:25 -0400
Received: from nexusel.demon.co.uk ([158.152.30.195]:12462 "HELO globe" ident: "NO-IDENT-SERVICE") by vger.rutgers.edu with SMTP id <971189-9428>; Fri, 24 Apr 1998 06:23:17 -0400
X-Mailer: exmh version 2.0zeta 7/24/97
To: David Woodhouse <Dave@imladris.demon.co.uk>
cc: Meelis Roos <mroos@tartu.cyber.ee>, linux-kernel@vger.rutgers.edu
Subject: Re: faster strcpy() 
In-reply-to: Your message of "Fri, 24 Apr 1998 11:14:34 +0200." <E0ySfV5-00058I-00@imladris.demon.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Apr 1998 11:26:09 +0100
From: Philip Blundell <pb@nexus.co.uk>
Message-Id: <E0ySfgI-0006zV-00@spring.nexus.co.uk>
Sender: owner-linux-kernel@vger.rutgers.edu

>It's something like subtracting 0x01010101 from the dword and oring with 
>0x80808080 to detect the carry, but that's not quite it. Perhaps you do 

/* The following magic check was designed by A. Mycroft. It yields a     */
/* nonzero value if the argument w has a zero byte in it somewhere. The  */
/* messy constants have been unfolded a bit in this code so that they    */
/* get preloaded into registers before relevant loops.                   */

#ifdef _copywords
#  define ONES_WORD   0x01010101
#  define EIGHTS_WORD (ones_word << 7)
#  define nullbyte_prologue_() \
      int ones_word = ONES_WORD;
#  define word_has_nullbyte(w) (((w) - ones_word) & ~(w) & EIGHTS_WORD)
#endif

p.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
