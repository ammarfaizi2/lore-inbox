Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <971607-29806>; Sat, 25 Apr 1998 18:25:01 -0400
Received: from gate.guardian.no ([195.1.254.2]:64765 "HELO lucifer.guardian.no" ident: "NO-IDENT-SERVICE") by vger.rutgers.edu with SMTP id <971605-29806>; Sat, 25 Apr 1998 18:24:03 -0400
Message-ID: <19980426004428.17045@lucifer.guardian.no>
Date: Sun, 26 Apr 1998 00:44:28 +0200
From: Alexander Kjeldaas <astor@guardian.no>
To: Philip Blundell <pb@nexus.co.uk>, David Woodhouse <Dave@imladris.demon.co.uk>
Cc: Meelis Roos <mroos@tartu.cyber.ee>, linux-kernel@vger.rutgers.edu
Subject: Re: faster strcpy()
References: <E0ySfV5-00058I-00@imladris.demon.co.uk> <E0ySfgI-0006zV-00@spring.nexus.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.89i
In-Reply-To: <E0ySfgI-0006zV-00@spring.nexus.co.uk>; from Philip Blundell on Fri, Apr 24, 1998 at 11:26:09AM +0100
Sender: owner-linux-kernel@vger.rutgers.edu

On Fri, Apr 24, 1998 at 11:26:09AM +0100, Philip Blundell wrote:
> >It's something like subtracting 0x01010101 from the dword and oring with 
> >0x80808080 to detect the carry, but that's not quite it. Perhaps you do 
> 
> /* The following magic check was designed by A. Mycroft. It yields a     */
> /* nonzero value if the argument w has a zero byte in it somewhere. The  */
> /* messy constants have been unfolded a bit in this code so that they    */
> /* get preloaded into registers before relevant loops.                   */
> 
> #ifdef _copywords
> #  define ONES_WORD   0x01010101
> #  define EIGHTS_WORD (ones_word << 7)
> #  define nullbyte_prologue_() \
>       int ones_word = ONES_WORD;
> #  define word_has_nullbyte(w) (((w) - ones_word) & ~(w) & EIGHTS_WORD)
> #endif
> 

I'm not sure why Mycroft used '& ~(w)' in the above. Unless something
obvious escapes me, you can optimize the above down to 3
instructions. Both codepaths have a dependency chain of 3
instructions.

#define word_has_nullbyte(w) ((((w) - 0x01010101) ^ (w)) & 0x80808080)

astor

-- 
 Alexander Kjeldaas, Guardian Networks AS, Trondheim, Norway
 http://www.guardian.no/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
