Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTFZTlK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 15:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbTFZTlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 15:41:10 -0400
Received: from fc.capaccess.org ([151.200.199.53]:52488 "EHLO fc.capaccess.org")
	by vger.kernel.org with ESMTP id S263298AbTFZTlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 15:41:04 -0400
Message-id: <fc.0010c7b200939d750010c7b200939d75.939d7c@capaccess.org>
Date: Thu, 26 Jun 2003 15:57:12 -0400
Subject: RAWBIT font 
To: linux-kernel@vger.kernel.org
From: "Rick A. Hohensee" <rickh@capaccess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alancox=/dev/null

echo "

If you source this file into your Bash shell, and maybe other post-Korn
shells, it should make a VGA font file named RAWBIT.VGAfont, using no
programs external to Bash. RAWBIT.VGAfont is a degenerate font that's 9
lines high and each glyph is vertical bitbars in the pattern of the ASCII
value being displayed, plus a couple 7's and a blank line for visual
indexing. It allows you to turn your unix workstation into a big UPC
scandcode. RAWBIT.VGAfont is particularly good for studying things like
Linus Torvalds' coding guidelines.

The data and routines used are from osimplay, my x86 assembler written in
Bash, with which one can produce other binary oddities like OS kernels and
VESA VBE 3.0 interfaces. Actually compembling a font line-by-line ala X
bitmaps takes several minutes on a Pentium 1 in osimplay, but this
degenerate little doohicky doesn't take long.


Rick Hohensee
Precision Mojo Engineer

" > $alancox



declare -i      H       C
octalbyte=({0,1,2,3}{0,1,2,3,4,5,6,7}{0,1,2,3,4,5,6,7})
                ## several doodads to have meta listings notes


hex=({0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f}{0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f})


opnote          ( ) { #         internal                        =shasm
        if test "$pass" = "2"           ; then
                echo -n "                       "$*"    " >> $listing
        fi
        }

allocated=yes
output=RAWBIT.VGAfont
listing=/dev/null
pass=2

ab              () { # assemble bytes.  pass-sensitive.         =shasm
if test "$pass" = "2"   ; then
        bytes $*
else
        H=H+$#
                                fi
                                }


bytes           ( ) { #                 internal                =shasm
        H=H+$#
        for a in $*     ;do
                if test $(($a)) -gt 255 ; then
                        echo " H " $H ":  index into hex[] > 255"
                fi
                if test "$allocated" = "yes"    ;then
                        echo -en \\${octalbyte[$a&0xff]}        >> $output
                fi
                if test $(($a)) -lt 0   ;then
                        let a=$a+256
                fi
                echo -n ${hex[$a]}" "                   >> $listing
        done
                                                }


let this=0
while  test $this -lt 256 ; do
        echo $this
        ab $this $this $this $this $this $this 7 7 0
        let this=$this+1
done

