Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264511AbUAASMj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 13:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbUAASMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 13:12:39 -0500
Received: from lmdeliver02.st1.spray.net ([212.78.202.115]:33276 "EHLO
	lmdeliver02.st1.spray.net") by vger.kernel.org with ESMTP
	id S264511AbUAASMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 13:12:32 -0500
From: Paolo Ornati <ornati@lycos.it>
To: William Lee Irwin III <wli@holomorphy.com>,
       Ed Sweetman <ed.sweetman@wmich.edu>
Subject: Re: 2.6.1-rc1
Date: Thu, 1 Jan 2004 19:12:04 +0100
User-Agent: KMail/1.5.2
References: <Pine.LNX.4.58.0312310033110.30995@home.osdl.org> <200312311434.17036.ornati@lycos.it>
In-Reply-To: <200312311434.17036.ornati@lycos.it>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0LG9/AAII7glZQK"
Message-Id: <200401011912.04358.ornati@lycos.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_0LG9/AAII7glZQK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 31 December 2003 14:34, Paolo Ornati wrote:
>
> With 2.6.1-rc1 I have noticed a strange IDE performance change.
>
> Results of "hdparm -t /dev/hda" with 2.6.0 kernel:
> (readahead = 256):		~26.31 MB/s
> (readahead = 128):		~31.82 MB/s
>
> PS = readahead is set to 256 by default on my system, 128 seems to be the
> best value
>
> Results of "hdparm -t /dev/hda" with 2.6.1-rc1 kernel:
> (readahead = 256):		~26.41 MB/s
> (readahead = 128):		~26.27 MB/s
>
....

I have done new interesting tests.

SCRIPT
___________________________________________________________
#!/bin/bash

echo "HD test for linux `uname -r`"
echo

MIN=32
MAX=512

ra=$MIN
while test $ra -le $MAX; do
    hdparm -a $ra /dev/hda > /dev/null;
    echo -n $ra$'\t';
    s1=`hdparm -t /dev/hda | grep 'Timing' | cut -d'=' -f2| cut -d' ' -f2`;
    s2=`hdparm -t /dev/hda | grep 'Timing' | cut -d'=' -f2| cut -d' ' -f2`;
    s=`echo "scale=2; ($s1+$s2)/2" | bc`;
    echo $s;
    ra=$(($ra+32));
done
___________________________________________________________


o Results for 2.6.0 (first column = readahead, second column = MB/s)

HD test for linux 2.6.0

32	13.78
64	31.74
96	31.77
128	31.74
160	31.84
192	31.87
224	31.21
256	26.31
288	21.75
320	27.22
352	27.46
384	31.63
416	28.15
448	28.25
480	31.54
512	26.24


o Results for 2.6.1-rc1

HD test for linux 2.6.1-rc1

32	26.20
64	26.26
96	26.99
128	26.29
160	26.28
192	25.89
224	26.55
256	26.46
288	30.86
320	26.74
352	26.15
384	25.86
416	26.42
448	26.46
480	26.82
512	26.46


A graphic is attached (red = 2.6.0 / green = 2.6.1-rc1 ;)


BYE

-- 
	Paolo Ornati
	Linux v2.4.23



--Boundary-00=_0LG9/AAII7glZQK
Content-Type: image/png;
  name="ide-hd.png"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ide-hd.png"

iVBORw0KGgoAAAANSUhEUgAAAg0AAAGMCAYAAABZHJF0AAAABmJLR0QA/wD/AP+gvaeTAAAACXBI
WXMAAAsSAAALEgHS3X78AAAAB3RJTUUH1AEBEgYtzIA2oQAAFAtJREFUeJzt3U9u4kq7B+DiKhto
D1lOhpGygkTdg7uUu5L+lLMCpAyzHIbuJXAHfZzPIQbeMv5bfh7pqE+M4XUZY35UlWFX18dTAgC4
4X/m3gAAYB2EBgAgRGgAAEKEBgAgRGgAAEKEBgAgRGgAAEIe5t4A2LKq2qe6Pn7+f5fm9vP7XdK1
fle9Ibfn0mPdc/+odp2hHxv4SmiABbkWEM5vm+INMmd7Ivevqv3N4JJjyMcCbjM8AQu3tDfFe7Zn
aW0B8uhpgBWo6+OiPlUPvT3XhhiaOufrNH939Xz0fbzz5e37X1p+qR1d23Tt8S89Tp/bYSxCAzCr
8/DRFUa6ll0KLn0f79J9L4WSW3WGXCfnbxiT0AAr1Xei4bVJlGM7rx0NAzmTL+95vGgwifQY9Fnn
Uq3c9sFYhAZYqb5vEreunhhS1+N1feovwVTtKGV/sU5CAzCaPldYrNG14Y6hlbC/WC9XT8AKLK37
eWnbA0xDaICFW1p39JDb0zXuf0+NrsebK+D0acOl7b92e99a0IfhCViQyByAa+teW3/s7ekrehli
38eb6kuwutowRHDoM8ESxrKr6+Np7o0AAJbP8AQAECI0AAAhQgMAECI0AAAhQgMAECI0AAAhQgMA
EBL+cqdbX/Liy0YAoGzhnoa6Pn7+d679e/PN7b7WFADKkj080Q4IAMB2LO63J94PH3NvAgAU7+n5
Mfs+WaGh75BD7v30YgDA8vS6eiL3Tb09H+LWf3OYq3djS3W31FZ1y667pbaqW27NvnXDoeFab0F7
8qM5DwBQpvDwxK0QICQAQNl8uRMAECI0AAAhQgMAECI0AAAhQgMAECI0AAAhQgMAECI0AAAhQgMA
ECI0AAAhQgMAECI0AAAhQgMAECI0AAAhQgMAECI0AAAhQgMAECI0AAAhQgMAEPIwR9Gq2l+9/f3w
kVJK6en58dsyyy233PI5l7epq25JdSN2dX089b73CKpqn+r6OGnN98PHlx2qbhk11VW3lJrqll13
TW01PAEAhAgNAECI0AAAhAgNAECI0AAAhAgNAECI0AAAhAgNAECI0AAAhAgNAECI0AAAhAgNAECI
0AAAhAgNAECI0AAAhAgNAECI0AAAhAgNAECI0AAAhDzk3qGq9l/+ruvj1eUAQBmyQkNV7TvDQBMY
2gHi0roAwDqFQ0MTDNo9CkIBAGzHrq6Pp8iKXb0Jzd/Xbmv/HfX2+y1rfQAg39PzY9b62XMa+sjp
kaiqfXYj7vV++Ji85tbqbqmt6pZdd0ttVbfcmk3dXK6eAABCwqHhfJJje9m12wCAMmQNT1wLAkIC
AJTN8AQAECI0AAAhQgMAECI0AAAhQgMAECI0AAAhQgMAECI0AAAhQgMAECI0AAAhQgMAECI0AAAh
QgMAECI0AAAhQgMAECI0AAAhQgMAECI0AAAhQgMAEPIwR9Gq2l+9/f3wkVJK6en58dsyyy233PI5
l7epq25JdSN2dX089b73CKpqn+r6OGnN98PHlx2qbhk11VW3lJrqll13TW01PAEAhAgNAECI0AAA
hAgNAECI0AAAhAgNAECI0AAAhAgNAECI0AAAhAgNAECI0AAAhAgNAECI0AAAhAgNAECI0AAAhAgN
AECI0AAAhAgNAEDIQ3TFqtp/W1bXx4u3t28DANYvHBoaXWGgCQzNbVW1T1W1FxwAoCDZoaHdoyAU
AMB2hEPDeUDQmwAA27Kr6+Opzx3bQxJdwxNdf0e9/X7rs0kAQIan58es9bOHJ/rI6Y2oqn12I+71
fviYvObW6m6preqWXXdLbVW33JpN3VyDXD3R9DaY7wAA5eo9pyH3dgBg3Xy5EwAQIjQAACFCAwAQ
IjQAACFCAwAQIjQAACFCAwAQIjQAACFCAwAQIjQAACFCAwAQIjQAACFCAwAQIjQAACFCAwAQIjQA
ACFCAwAQIjQAACFCAwAQIjQAACEPcxStqv3V298PHymllJ6eH78ts9xyyy2fc3mbuuqWVDdiV9fH
U+97j6Cq9qmuj5PWfD98fNmh6pZRU111S6mpbtl119RWwxMAQIjQAACECA0AQIjQAACECA0AQIjQ
AACECA0AQIjQAACECA0AQIjQAACECA0AQIjQAACECA0AQIjQAACECA0AQIjQAACECA0AQIjQAACE
PPS5U1XtU0op1fXx27JG+zYAYP2yexrOw0F7WV0fP8NC13oAwHplhYaq2utBAICNCocGgQEAtm1X
18dTZMVLww11ffw2x+HS31Fvv9+y1gcA8j09P2atH54I2TXpMdrzkNNDUVX77Ebc6/3wMXnNrdXd
UlvVLbvultqqbrk1m7q5Brnkst2jkBsoAIB16HXJZVcgEBIAoGy+3AkACBEaAIAQoQEACBEaAIAQ
oQEACBEaAIAQoQEACBEaAIAQoQEACBEaAIAQoQEACBEaAIAQoQEACBEaAIAQoQEACBEaAIAQoQEA
CBEaAIAQoQEACBEaAICQhzmKVtX+6u3vh4+UUkpPz4/fllluueWWz7m8TV11S6obsavr46n3vUdQ
VftU18dJa74fPr7sUHXLqKmuuqXUVLfsumtqq+EJACBEaAAAQoQGACBEaAAAQoQGACBEaAAAQoQG
ACBEaAAAQoQGACBEaAAAQoQGACBEaAAAQmb5lUuY0o8bv6qa48/EP6YGsCRCw53ueUN6GXA7ll53
7rYO9WZ/7fkWKIDSCQ0D6PtmsaafQ11jzTHqXnuu24GiKyQJFcylOTYdg+PZyj4WGu7wo9oXf4AQ
1z4WusKKXgqm1n4j+1HtnbNGcr6fS97HQgNMJNpLcWtdiDh/82r+fyufiKfQtS+b4HC+vBRCAyzA
+cml5JPOuerHPtV/ym/nVG4dO8LD/SL7uNSenXBoqDq6VuvWzji/vS5sR50r8WBgOUo+6TSqH3/P
GfWf45f/p5/cECA85MvZV+39W9K+DYeG8xBQVftUVftU18fPwNCs074N6KfUk05K6VtIaP7V69DP
PW/8wsNt9+7fkl7Dhidg4UoaI73Vo6DXIc+Qx4Xw8N1Q+6Kk4LCr6+MpuvKlIYiunoauv6Pefr9l
rT+1l1+v6Z+FbyPlefn1mlJKqz32Xn/+3f63/8S2//Xna3jdLRr7eFj78XaPsdq+xH2ae0l6Vmho
aweDW6Eh93GnHtbIvZZ/qMRYyncXLLVmqXWvHX9LbO89PQe37rvFY3nKnoD2VT1Tf0qeYz9P0d6u
52/uYyqH356AlWkPVyzdvUMN9Z/jlyGLrZt66OBPffz8VLyWY66vpn3//H4bdf/+qY+reg2fG+Tq
iaa3ob1OqZMgSxmXYt3WMM9hyEmNW5/r8KPap5c033Nd8nyHb206fExSd63zHHpfPZF7OzCspV6W
Odab+1avsGh/An6aeVtKCg9LaMNn+F/QHIdbXD0BK7a0yzKn6A1o9zq8pfWcbHPN9Qk4Ys3hYWnb
/Kc+ppeFbdM1QkOGpZyY4VzziWWuLuzmyoipegA+ex1+ltnrsLQ3tkvWFB6WvI3//H5LL79eV/Ee
IzRAIeYarphzrsHbf95S9bOcuQ5LfmO7ZsnhYYnb1GVpvYaXuHoCCtLM/J5iZnb1Y/85v2DO71Mo
5QqLtby5XdO+MmDuqwPaAXpN+3TpV1boaQhaevqDtrGvrljilQxrvcKihLBwbojg8DLQdqzRkq+s
EBqgUGMNVyz56oW1XWGx1DeGIdzbrrm+8GgplnpZteEJKNiQXyTTHo5YuqbXYalDFku8VJblOZ8r
sgR6GgK8uFm7e7s719jtP2evw62TvPMJUUubICk0wEb06e5cY1g413euw6U3/shY+xJO7pRlKfMc
hAbYkJx5DiUEhkZXr0Pf3oCtj7UznyUEB6HhhrmfoJRS1rhsCSd4xnWru7OksHCu6XU47fQGsE5z
T5AUGmbUfIteROQEHp749bPMNwTydJ18Sg4MKf0NSqf0t72XXiultp2YnPPyYH7+/Sd67M35uzNC
wwjm6hmIPlbOrHIn0PENOsP/Z+b6p5ROu79vprtT2c/3eUDqamvotZF5gt+Kwa9UyT2WBzT1c/t+
+EivP1/z9uHp33920waHokJD74P2wsF52qW0O6WUUv7jRg6698NHSs/ZD323t/+8hcZkB71kbeQT
wBJP4HMEsz7j7X/qv//+PfkMtimLEu3Ojb5uc07wSzw2cwzdIxo119yRuc7Lfffd1K/ZokJD351+
+eBcxzXpY1nTCeDiCTwQVnLbWeoQ0NxjpWMZowt3jF69mwY+psyVoo+iQgPbdemkFgkruSf1Jfci
3WvOsdIxzN2OoYN38+NcQyn5WGYcQsMFc59smI5PUV8t7ctk+lr79ndxrDI3XyMNdFrKrxX2UWJg
gCUQGoCLlvjd99eUNLQCSzTL8ER14wT0fvhIKaUvY9HNsimWv/x6/TzpTFnXcssXufz3W0oppZfW
JMklbufLr9fP7RuzbtuU7VVX3bHrRuzq+njqfe8RVNU+1RN/SjifLDfVJ5U5Lymauu6W2lpy3UtX
V8zd3imv+pi7reqWV3dNbTUREghb4iTJJW0LlM6chjNOQHDbUiZJtocSgfEJDUAvc0+S/FHt0z//
zrcApmF4omXuT02wNk1weJmwh+7L/IU7JnQB+fQ0nNHVCfn++f02yXBFiV9zDWsiNACDGHu4QmCA
+Rme+JehCbjfWFdXmKAMy6CnocVJCYYx5NUVAgMsh9AAjGKI4QqBAZbF8ERKn18/CwzrPDjkBACB
AZZHT8O/nJxgPDm9Dn50CpZLaAAm8ac+fs51uMQVErBsmw8NrpqAaV2aJCkwwPJtPjSklHwVLUzs
fLiiGY4QGGDZTIQEZrHEX8wErtt0T4OhCZifwADrsenQkJITFgBEbT40AAAx4TkNVUdXft36lH5+
e73wT/DGUQEgT7inoa6PX/5L6b9Bofm36zYAoAyGJwCAkF6hod2zsEaGJgAg366uj6ecO3QFhvNl
l/6Oehv5y5Zefr36QicANu/p+TFr/awvd+rbw5CzflXtsxvRR7vG++FjkprntlR3S21Vt+y6W2qr
uuXWbOrm6nX1RPv/m8mPVbX/tnyJDE0AQD/h0HArBCw1JAAAw3D1BAAQsqnQYGgCAPrbVGgAAPoT
GgCAkM2EBkMTAHCfzYQGAOA+QgMAELKJ0GBoAgDut4nQAADcT2gAAEKKDw2GJgBgGMWHBgBgGEID
ABBSdGgwNAEAwyk6NAAAwxEaAICQYkODoQkAGFaxoQEAGJbQAACEFBkaDE0AwPAe5ihaVfurt78f
PlJKKT09P35bZrnllls+5/I2ddUtqW7Erq6Pp973HkFV7VN9Zy9Bbk/D++Hjyw6dypbqbqmt6pZd
d0ttVbfcmn3rFjc8YWgCAMZRXGgAAMYhNAAAIUWFBkMTADCeokIDADCeokKDXgYAGE9RoQEAGI/Q
AACECA0AQIjQAACECA0AQIjQAACECA0AQIjQAACECA0AQIjQAACECA0AQIjQAACEPERXrKr9l7/r
sx+HunU7ALBu4Z6Guj5eDAJNYGivcx4iAIB1MzwBAIQIDQBAyK6uj6ecO7SHIi4tu/R31Nvvt6z1
AYB8T8+PWeuHJ0LeI2dSZFXtsxtxr/fDx+Q1t1Z3S21Vt+y6W2qruuXWbOrm6n31xPnkx6raf1nH
1RMAUJZwaLgVAoQEACibiZAAQIjQAACECA0AQIjQAACECA0AQIjQAACECA0AQIjQAACECA0AQIjQ
AACECA0AQIjQAACECA0AQIjQAACECA0AQIjQAACECA0AQIjQAACECA0AQIjQAACEPMxRtKr2V29/
P3yklFJ6en78tsxyyy23fM7lbeqqW1LdiF1dH0+97z2Cqtqnuj5OWvP98PFlh6pbRk111S2lprpl
111TWw1PAAAhQgMAECI0AAAhQgMAECI0AAAhQgMAECI0AAAhQgMAECI0AAAhQgMAECI0AAAhQgMA
ECI0AAAhQgMAECI0AAAhQgMAECI0AAAhQgMAEPIw1ANV1f7L33V9HOqhAYAFGKSnoQkMdX38DAvn
IQIAWDfDEwBAiNAAAIQMNqfhmryhiv8ztAEAE8idfzhJaMifFPm/vepU1X7yCZhz1FS37Lpbaqu6
5dZUt8y6gwxPtCc/tidFAgDlGKynQUgAgLKZCAkAhAgNAECI0AAAhAgNAECI0AAAhAgNAEDIrq6P
p7k3AgBYPj0NAECI0AAAhAgNAECI0AAAhAgNAEDIJD+NPbbmlzUbY/941nm9KWouoXbXNoxZu6ut
Y9e8VH+OY2rO2lPs4ylet9EaQz/XkbpDt//W4431PPdp6xC1c/ffUM9xn/18b81I3a71xnhNFXXJ
5RQ/y931u+VTvoleqj3lG2ldHyfb12PXiNae8vfqL23DVDXmrDtWzWttat82dNsjjzdFzSnOW5fa
MfZ5K7qPh35+r7V3qBo5dbtuG+M1ZXgiU9cTMNWbydw/Pz7HG+ccul6UJQaGJbrW4zJmvWY/t0+2
JXHeKv91NNV5q4jhCcY35wtv6uGnuesCw3DeGr6u0DCAOYYI2qYY857rhdfVbT7V9pzXnqrulMdT
1ydr4WgbnLfGU/J5S2i40xzdyHO8mV3qrh2z9vnjtsckGcZccxqa59LzOQ/nLeetvoSGnrb0ySwy
4YZhbGm/RmedMxznre28vsZiImQP7QNvyoNvayfV8/ZO1X4nlGm0n8+5TubnwzMlv6k4b02j9PNW
EZdcTnk9/60DoNRr6i9tR8ntnev7P+a6UqNtjn085et1qssPr9Ud+rx17fHGPG/1bevQ31sQedwh
XmNLb+/Y560iQgMAMD7DEwBAiNAAAIQIDQBAiNAAAIQIDQBAyP8D4d1oGhfUhbQAAAAASUVORK5C
YII=

--Boundary-00=_0LG9/AAII7glZQK--

