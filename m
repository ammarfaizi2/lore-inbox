Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272989AbRINR5W>; Fri, 14 Sep 2001 13:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272988AbRINR5L>; Fri, 14 Sep 2001 13:57:11 -0400
Received: from [207.167.207.80] ([207.167.207.80]:25061 "EHLO mx.atitech.ca")
	by vger.kernel.org with ESMTP id <S272985AbRINR4z>;
	Fri, 14 Sep 2001 13:56:55 -0400
Message-ID: <761E23C7F09AD51188990008C74C26141221@fgl00exh01.atitech.com>
From: Alexander Stohr <AlexanderS@ati.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.10-pre9 min/max raises "const" warnings
Date: Fri, 14 Sep 2001 19:55:35 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

try this one:

  int a, b, c, d;
  d = min( a, min( b, c ));

and you will see a gnu c warning about multiple const qualifiers.
(this might depend on the warning level you drive.)

fix it with this code:

  #define min(x,y) ({ \

      const typeof(x) _x = (x);       \

      const typeof(y) _y = (y);       \

      (void) (&_x == &_y);            \

      (_x < _y) ? (typeof(x)) _x : (typeof(y)) _y; })

simply the last line has changed towards linux kernel patch-2.4.10-pre9 from
ftp.
the same change should apply for the max() macro.

i am yet not sure if the used "? :" operator set does qualify as
a left-value. maybe this could be another important reason why 
return types here should stay identical to input types.

regards AlexS.

PS: i am not subscribed to this list.

